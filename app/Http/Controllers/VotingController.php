<?php

namespace App\Http\Controllers;

use App\Models\News;
use App\Models\Vote;
use Inertia\Inertia;
use Paypack\Paypack;
use App\Models\Payment;
use App\Models\Setting;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class VotingController extends Controller
{
    /**
     * Display the voting page
     */
    public function index()
    {
        // Eager load candidates with each category
        $categories = Category::with([
            'candidates' => function ($query) {
                $query->orderBy('order', 'asc');
            }
        ])->get();

        $news = News::take(3)->orderBy('created_at')->get();

        // Transform the data for frontend
        $categories = $categories->map(function ($category) {
            return [
                'id' => $category->id,
                'name' => $category->name,
                'league' => $category->league,
                'candidates' => $category->candidates->map(function ($candidate) {
                    return [
                        'id' => $candidate->id,
                        'name' => $candidate->name,
                        'image' => $candidate->image,
                        'code' => $candidate->code,
                        'order' => $candidate->order,
                    ];
                }),
            ];
        });

        $vote_amount = (int) Setting::where('name', 'vote_amount')->first()->value;

        return Inertia::render('Welcome', compact('categories', 'vote_amount', 'news'));
    }

    public function news_details($slug)
    {
        try {
            $news = News::where('slug', $slug)->firstOrFail();
            return Inertia::render('NewsDetails', [
                'news' => $news
            ]);
        } catch (\Exception $e) {
            return redirect()->route('news.index')
                ->with('error', 'News article not found.');
        }
    }



    public function processPayment(Request $request)
    {
        $vote_amount = (int) Setting::where('name', 'vote_amount')->first()->value;
        // dd($request->all());
        // Validate the request
        $validator = Validator::make($request->all(), [
            'candidateId' => 'required|exists:candidates,id',
            'votes' => 'required|integer|min:1|max:100',
            'phoneNumber' => [
                'required',
                'string',
                'regex:/^07\d{8}$/' // Must start with '07' and be exactly 10 digits
            ],
            'paymentMethod' => 'required|in:mtn,airtel',
            'categoryId' => 'required|exists:categories,id',
            'amount' => 'required|numeric|min:' . $vote_amount,
        ], [
            'phoneNumber.regex' => 'Phone number must start with 07 and be exactly 10 digits long.',
        ]);

        if ($validator->fails()) {
            return back()->withErrors($validator)->withInput();
        }

        try {
            // Check if phone number has already voted for this candidate in this category
            $existingVote = Payment::where('phone_number', $request->phoneNumber)
                ->where('category_id', $request->categoryId)
                // ->where('candidate_id', $request->candidateId)
                ->where('status', 'successful')
                ->first();

            if ($existingVote) {
                return back()->withErrors([
                    'phoneNumber' => 'Iyi nimero ya telefoni yamaze gutora muri iki cyiciro.'
                ]);
            }


            $paypack = new Paypack();

            $paypack->config([
                'client_id' => env('PAYPACK_CLIENT_ID'),
                'client_secret' => env('PAYPACK_CLIENT_SECRET'),
            ]);
            $cashin = $paypack->Cashin([
                'phone' => $request->phoneNumber,
                'amount' => $request->amount,
            ]);

            // Create payment record
            $payment = Payment::create([
                'candidate_id' => $request->candidateId,
                'category_id' => $request->categoryId,
                'phone_number' => $request->phoneNumber,
                'payment_method' => $request->paymentMethod,
                'amount' => $request->amount,
                'votes' => $request->votes,
                'status' => 'pending', // Initial status
                'transaction_id' => $cashin['ref'] ?? null
            ]);

            Vote::create([
                'candidate_id' => $request->candidateId,
                'payment_id' => $payment->id,
            ]);

            $payment->update(['status' => 'initiated']);

            return back()->with('success', 'Payment initiated successfully.');
        } catch (\Exception $e) {
            return back()->withErrors(['error' => 'An error occurred while processing your payment. Please try again.']);
        }
    }

}
