<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Inertia\Inertia;

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
}
