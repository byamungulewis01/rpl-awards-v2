<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\League;
use App\Models\Category;
use App\Models\Candidate;
use App\Models\Nomination;
use App\Models\User;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\DB;

class AdminNominationController extends Controller
{
    /**
     * Display the admin nominations dashboard
     */
    public function dashboard(Request $request)
    {
        // Get all leagues
        $leagues = League::where('status', 'active')->get();

        // Get active league ID from request or use first league
        $activeLeagueId = $request->query('league', $leagues->first()->id);
        $activeLeague = League::find($activeLeagueId);

        // Get categories for active league
        $categories = Category::where('league_id', $activeLeagueId)
            ->where('status', 'active')
            ->get();

        // Get active category ID from request or use first category
        $activeCategoryId = $request->query('category', $categories->first()->id);
        $activeCategory = Category::find($activeCategoryId);

        // Get voting statistics for the active category
        $votingStats = $this->getVotingStats($activeCategoryId);

        // Get voter activity data
        $voterActivity = $this->getVoterActivity($activeLeagueId);

        // Get category completion data
        $categoryCompletion = $this->getCategoryCompletion($activeLeagueId);

        return Inertia::render('Admin/NominationDashboard', [
            'leagues' => $leagues,
            'categories' => $categories,
            'activeLeague' => $activeLeague,
            'activeCategory' => $activeCategory,
            'votingStats' => $votingStats,
            'voterActivity' => $voterActivity,
            'categoryCompletion' => $categoryCompletion,
        ]);
    }

    /**
     * Get voting statistics for a specific category
     */
    private function getVotingStats($categoryId)
    {
        // Get candidates with nomination counts
        $candidates = Candidate::where('category_id', $categoryId)
            ->withCount('nominations')
            ->with('team')
            ->orderByDesc('nominations_count')
            ->get();

        // Calculate voting percentages
        $totalVotes = $candidates->sum('nominations_count');

        // Format data for frontend
        $candidateData = $candidates->map(function($candidate) use ($totalVotes) {
            return [
                'id' => $candidate->id,
                'name' => $candidate->name,
                'image' => $candidate->image,
                'team' => $candidate->team ? $candidate->team->name : null,
                'votes' => $candidate->nominations_count,
                'percentage' => $totalVotes > 0
                    ? round(($candidate->nominations_count / $totalVotes) * 100, 1)
                    : 0
            ];
        });

        return [
            'candidates' => $candidateData,
            'totalVotes' => $totalVotes
        ];
    }

    /**
     * Get voter activity data grouped by role
     */
    private function getVoterActivity($leagueId)
    {
        // Get categories for this league
        $categoryIds = Category::where('league_id', $leagueId)
            ->where('status', 'active')
            ->pluck('id');

        // Get voting activity by user role
        $roleActivity = DB::table('nominations')
            ->join('users', 'nominations.user_id', '=', 'users.id')
            ->whereIn('nominations.category_id', $categoryIds)
            ->select('users.role', DB::raw('COUNT(DISTINCT nominations.user_id) as voters_count'), DB::raw('COUNT(*) as votes_count'))
            ->groupBy('users.role')
            ->get();

        // Most active voters
        $activeVoters = DB::table('nominations')
            ->join('users', 'nominations.user_id', '=', 'users.id')
            ->whereIn('nominations.category_id', $categoryIds)
            ->select(
                'users.id',
                'users.name',
                'users.role',
                DB::raw('COUNT(DISTINCT nominations.category_id) as categories_voted'),
                DB::raw('COUNT(*) as total_votes')
            )
            ->groupBy('users.id', 'users.name', 'users.role')
            ->orderByDesc('categories_voted')
            ->orderByDesc('total_votes')
            ->limit(10)
            ->get();

        return [
            'roleActivity' => $roleActivity,
            'activeVoters' => $activeVoters
        ];
    }

    /**
     * Get category completion data
     */
    private function getCategoryCompletion($leagueId)
    {
        // Get all categories for this league
        $categories = Category::where('league_id', $leagueId)
            ->where('status', 'active')
            ->get();

        // Get total number of users who can vote
        $totalVoters = User::whereIn('role', ['coach', 'journalist', 'team_captain'])->count();

        // Calculate completion percentage for each category
        $completion = $categories->map(function($category) use ($totalVoters) {
            // Count distinct users who voted in this category
            $votersCount = Nomination::where('category_id', $category->id)
                ->distinct('user_id')
                ->count('user_id');

            return [
                'id' => $category->id,
                'name' => $category->name,
                'votersCount' => $votersCount,
                'totalVoters' => $totalVoters,
                'completionPercentage' => $totalVoters > 0
                    ? round(($votersCount / $totalVoters) * 100, 1)
                    : 0
            ];
        });

        return $completion;
    }

    /**
     * Export voting data as CSV
     */
    public function exportVotingData(Request $request)
    {
        $categoryId = $request->query('category');
        $category = Category::findOrFail($categoryId);

        // Get all nominations for this category with related data
        $nominations = Nomination::where('category_id', $categoryId)
            ->with(['user', 'candidate.team'])
            ->get();

        // Prepare CSV headers
        $headers = [
            "Content-type" => "text/csv",
            "Content-Disposition" => "attachment; filename=voting_data_{$category->name}.csv",
            "Pragma" => "no-cache",
            "Cache-Control" => "must-revalidate, post-check=0, pre-check=0",
            "Expires" => "0"
        ];

        // Create CSV content
        $callback = function() use ($nominations) {
            $file = fopen('php://output', 'w');

            // Add CSV headers
            fputcsv($file, ['Voter Name', 'Voter Role', 'Candidate Name', 'Team', 'Nomination Date']);

            // Add nomination data
            foreach ($nominations as $nomination) {
                fputcsv($file, [
                    $nomination->user->name,
                    $nomination->user->role,
                    $nomination->candidate->name,
                    $nomination->candidate->team ? $nomination->candidate->team->name : 'N/A',
                    $nomination->created_at->format('Y-m-d H:i:s')
                ]);
            }

            fclose($file);
        };

        return response()->stream($callback, 200, $headers);
    }
}
