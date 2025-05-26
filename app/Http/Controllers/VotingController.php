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

        // return response()->json($categories);

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
                        'stats' => $candidate->stats,
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



    // public function processVote(Request $request)
    // {
    //     // Validate the request
    //     $validator = Validator::make($request->all(), [
    //         'candidateId' => 'required|exists:candidates,id',
    //         'categoryId' => 'required|exists:categories,id',
    //     ]);

    //     if ($validator->fails()) {
    //         return back()->withErrors($validator)->withInput();
    //     }

    //     try {
    //         // Get user's IP address as a unique identifier
    //         $userIp = $request->ip();

    //         // Check if this IP has already voted for this category
    //         $existingVote = Vote::where('ip_address', $userIp)
    //             ->where('category_id', $request->categoryId)
    //             ->first();

    //         if ($existingVote) {
    //             return back()->withErrors([
    //                 'duplicate' => 'Wamaze gutora muri iki cyiciro.'  // "You have already voted in this category" in Kinyarwanda
    //             ]);
    //         }

    //         // Create vote record directly
    //         Vote::create([
    //             'candidate_id' => $request->candidateId,
    //             'category_id' => $request->categoryId,
    //             'ip_address' => $userIp,
    //         ]);

    //         return back()->with('success', 'Itora ryakozwe neza.');  // "Voting completed successfully" in Kinyarwanda
    //     } catch (\Exception $e) {
    //         return back()->withErrors(['error' => 'Hari ikibazo cyabaye. Ongera ugerageze.']);  // "An error occurred. Please try again" in Kinyarwanda
    //     }
    // }

    public function inspector()
    {
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
                        'order' => $candidate->order,
                        'votes_count' => $candidate->votes_count,
                    ];
                }),
            ];
        });

        return Inertia::render('Inspector', compact('categories'));
    }

    public function processVote(Request $request)
    {
        // Validate the request
        $validator = Validator::make($request->all(), [
            'candidateId' => 'required|exists:candidates,id',
            'categoryId' => 'required|exists:categories,id',
        ]);

        if ($validator->fails()) {
            return back()->withErrors($validator)->withInput();
        }

        try {
            // Method 1: Session + Device Fingerprint (Recommended)
            if ($this->hasAlreadyVotedBySession($request)) {
                return back()->withErrors([
                    'duplicate' => 'Wamaze gutora muri iki cyiciro.'
                ]);
            }

            // Create vote record
            Vote::create([
                'candidate_id' => $request->candidateId,
                'category_id' => $request->categoryId,
                'ip_address' => $request->ip(),
                'session_id' => session()->getId(),
                'device_fingerprint' => $this->generateDeviceFingerprint($request),
                'device_name' => $request->header('User-Agent'),

            ]);

            return back()->with('success', 'Itora ryakozwe neza.');
        } catch (\Exception $e) {
            return back()->withErrors(['error' => 'Hari ikibazo cyabaye. Ongera ugerageze.']);
        }
    }

    // Method 1: Session + Device Fingerprint validation
    private function hasAlreadyVotedBySession(Request $request)
    {
        $sessionId = session()->getId();
        $deviceFingerprint = $this->generateDeviceFingerprint($request);

        return Vote::where(function ($query) use ($sessionId, $deviceFingerprint, $request) {
            $query->where('session_id', $sessionId)
                ->orWhere('device_fingerprint', $deviceFingerprint);
        })
            ->where('category_id', $request->categoryId)
            ->exists();
    }



    // Generate device fingerprint
    private function generateDeviceFingerprint(Request $request)
    {
        $components = [
            $request->header('User-Agent'),
            $request->header('Accept-Language'),
            $request->header('Accept-Encoding'),
            $request->ip(),
            $request->userAgent(),
            $request->header('Referer'),
            $request->header('Accept'),
            $request->header('Accept-Charset'),
            $request->header('Accept-Language'),
            $request->header('Accept-Encoding'),
            $request->header('Accept-Language'),
            $request->header('Accept-Encoding'),
            // Add more browser/device characteristics
        ];

        return hash('sha256', implode('|', array_filter($components)));
    }




    public function voting()
    {
        // Eager load candidates with each category
        $categories = Category::with([
            'candidates' => function ($query) {
                $query->orderBy('order', 'asc');
            }
        ])->get();

        // return response()->json($categories);

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
                        'stats' => $candidate->stats,
                    ];
                }),
            ];
        });


        return Inertia::render('Voting', compact('categories'));
    }
}
