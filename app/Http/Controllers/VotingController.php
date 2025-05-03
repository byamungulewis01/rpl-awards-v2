<?php

namespace App\Http\Controllers;

use App\Models\Vote;
use Inertia\Inertia;
use App\Models\Payment;
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

        return Inertia::render('Welcome', compact('categories'));
    }


    public function processPayment(Request $request)
    {
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
            'amount' => 'required|numeric|min:200',
        ], [
            'phoneNumber.regex' => 'Phone number must start with 07 and be exactly 10 digits long.',
        ]);

        if ($validator->fails()) {
            return back()->withErrors($validator)->withInput();
        }

        try {
            // Create payment record
            $payment = Payment::create([
                'candidate_id' => $request->candidateId,
                'phone_number' => $request->phoneNumber,
                'payment_method' => $request->paymentMethod,
                'amount' => $request->amount,
                'votes' => $request->votes,
                'status' => 'pending', // Initial status
                'transaction_id' => 'VP' . time() . rand(1000, 9999), // Generate a unique transaction ID
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
