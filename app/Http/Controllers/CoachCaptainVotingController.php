<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Category;
use App\Models\News;
use App\Models\CoachCaptainVote;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;

class CoachCaptainVotingController extends Controller
{

    public function voting()
    {
        $user = Auth::user();

        // Get user's existing votes
        $userVotes = CoachCaptainVote::where('user_id', $user->id)
            ->with(['candidate', 'category'])
            ->get();

        // Create a mapping of category_id => candidate_id for quick lookup
        $votedCandidates = $userVotes->pluck('candidate_id', 'category_id')->toArray();

        // Eager load candidates with each category
        $categories = Category::with([
            'candidates' => function ($query) {
                $query->orderBy('order', 'asc');
            }
        ])->get();

        $news = News::take(3)->orderBy('created_at')->get();

        // Transform the data for frontend
        $categories = $categories->map(function ($category) use ($votedCandidates) {
            $categoryVotedCandidate = $votedCandidates[$category->id] ?? null;

            return [
                'id' => $category->id,
                'name' => $category->name,
                'league' => $category->league,
                'hasVoted' => isset($votedCandidates[$category->id]),
                'votedCandidateId' => $categoryVotedCandidate,
                'candidates' => $category->candidates->map(function ($candidate) use ($categoryVotedCandidate) {
                    return [
                        'id' => $candidate->id,
                        'name' => $candidate->name,
                        'image' => $candidate->image,
                        'code' => $candidate->code,
                        'order' => $candidate->order,
                        'stats' => $candidate->stats,
                        'isVoted' => $candidate->id == $categoryVotedCandidate,
                    ];
                }),
            ];
        });

        return Inertia::render('Voting', compact('categories'));
    }

    // store auth user vote
    public function storeVote(Request $request)
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
            $userId = Auth::user()->id;

            // check if the user has already voted in this category
            $existingVote = CoachCaptainVote::where('user_id', $userId)
                ->where('category_id', $request->categoryId)
                ->first();

            if ($existingVote) {
                // If voting for the same candidate, show message
                if ($existingVote->candidate_id == $request->candidateId) {
                    return back()->withErrors([
                        'duplicate' => 'Wamaze gutora uyu mukandida muri iki cyiciro.'
                    ]);
                }

                // If voting for different candidate, update the vote
                $existingVote->update([
                    'candidate_id' => $request->candidateId
                ]);

                return back()->with('success', 'Itora ryawe ryavuguruwe neza.');
            }

            // Create new vote record
            CoachCaptainVote::create([
                'candidate_id' => $request->candidateId,
                'category_id' => $request->categoryId,
                'user_id' => $userId,
            ]);

            return back()->with('success', 'Itora ryakozwe neza.');
        } catch (\Exception $e) {
            return back()->withErrors(['error' => 'Hari ikibazo cyabaye. Ongera ugerageze.']);
        }
    }
}