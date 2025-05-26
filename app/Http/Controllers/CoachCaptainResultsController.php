<?php

namespace App\Http\Controllers;

use App\Models\User;
use Inertia\Inertia;
use App\Http\Resources\VoterResultResource;

class CoachCaptainResultsController extends Controller
{
    public function results()
    {
        $voters = User::whereIn('role', ['coach', 'team_captain'])->get();

        $results = VoterResultResource::collection($voters);
        // Get vote counts for each category
        $bestPlayerVotes = \App\Models\CoachCaptainVote::where('category_id', 1)
            ->selectRaw('candidate_id, COUNT(*) as vote_count')
            ->groupBy('candidate_id')
            ->orderByDesc('vote_count')
            ->with('candidate')
            ->get()
            ->map(function($vote) {
                return [
                    'name' => $vote->candidate->name,
                    'votes' => $vote->vote_count
                ];
            });

        $bestCoachVotes = \App\Models\CoachCaptainVote::where('category_id', 3)
            ->selectRaw('candidate_id, COUNT(*) as vote_count')
            ->groupBy('candidate_id')
            ->orderByDesc('vote_count')
            ->with('candidate')
            ->get()
            ->map(function($vote) {
                return [
                    'name' => $vote->candidate->name,
                    'votes' => $vote->vote_count
                ];
            });

        $bestYouthVotes = \App\Models\CoachCaptainVote::where('category_id', 4)
            ->selectRaw('candidate_id, COUNT(*) as vote_count')
            ->groupBy('candidate_id')
            ->orderByDesc('vote_count')
            ->with('candidate')
            ->get()
            ->map(function($vote) {
                return [
                    'name' => $vote->candidate->name,
                    'votes' => $vote->vote_count
                ];
            });

        $bestKeeperVotes = \App\Models\CoachCaptainVote::where('category_id', 5)
            ->selectRaw('candidate_id, COUNT(*) as vote_count')
            ->groupBy('candidate_id')
            ->orderByDesc('vote_count')
            ->with('candidate')
            ->get()
            ->map(function($vote) {
                return [
                    'name' => $vote->candidate->name,
                    'votes' => $vote->vote_count
                ];
            });




        return Inertia::render('Results', [
            'results' => $results,
            'bestPlayerVotes' => $bestPlayerVotes,
            'bestCoachVotes' => $bestCoachVotes,
            'bestYouthVotes' => $bestYouthVotes,
            'bestKeeperVotes' => $bestKeeperVotes,
        ]);
    }


}