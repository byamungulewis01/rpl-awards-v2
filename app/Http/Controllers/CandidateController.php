<?php

namespace App\Http\Controllers;

use App\Models\Candidate;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class CandidateController extends Controller
{
    /**
     * Store a newly created candidate.
     */
    public function store(Request $request)
    {
        try {
            // Validate the request
            $validatedData = $request->validate([
                'category_id' => 'required|exists:categories,id',
                'name' => 'required|string|max:255',
                'order' => 'required|integer|min:1',
                'status' => 'required|in:active,inactive',
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            ]);

            // Handle image upload

            if ($request->hasFile('image')) {
                $image = $request->file('image');
                $imageName = time() . '_' . $image->getClientOriginalName();
                $image->move('candidates', $imageName);
                $validatedData['image'] = "candidates/{$imageName}";
            }

            // Create the candidate
            Candidate::create($validatedData);

            return redirect()->back()->with('success', 'Candidate created successfully.');
        } catch (\Illuminate\Validation\ValidationException $e) {
            throw $e;
        } catch (\Exception $e) {
            dd($e->getMessage());
            return redirect()->back()
                ->withInput()
                ->withErrors(['error' => 'Failed to create Candidate: ' . $e->getMessage()]);
        }
    }

    /**
     * Update the specified candidate.
     */
    public function update(Request $request, Candidate $candidate)
    {
        try {
            // Validate the request
            $validatedData = $request->validate([
                'category_id' => 'required|exists:categories,id',
                'name' => 'required|string|max:255',
                'order' => 'required|integer|min:1',
                'status' => 'required|in:active,inactive',
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            ]);


            // Handle image upload

            if ($request->hasFile('image')) {
                // Delete old image
                if (file_exists($candidate->image)) {
                    unlink($candidate->image);
                }

                $image = $request->file('image');
                $imageName = time() . '_' . $image->getClientOriginalName();
                $image->move('candidates', $imageName);
                $validatedData['image'] = "candidates/{$imageName}";
            } else {
                $validatedData['image'] = $candidate->image;
            }

            // Update the candidate
            $candidate->update($validatedData);

            return redirect()->back()->with('success', 'Candidate updated successfully.');
        } catch (\Illuminate\Validation\ValidationException $e) {
            throw $e;
        } catch (\Exception $e) {
            return redirect()->back()
                ->withInput()
                ->withErrors(['error' => 'Failed to update Candidate: ' . $e->getMessage()]);
        }
    }

    public function updateStats(Request $request, Candidate $candidate)
    {
        try {
            $validatedData = $request->validate([
                'stats' => 'required|array',
            ]);

            $candidate->stats = $validatedData['stats'];
            $candidate->save();

            return redirect()->back()->with('success', 'Candidate statistics updated successfully.');
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Failed to update candidate statistics: ' . $e->getMessage());
        }
    }

    /**
     * Update the order of a candidate.
     */
    public function updateOrder(Request $request, Candidate $candidate)
    {
        try {
            $validatedData = $request->validate([
                'order' => 'required|integer|min:1',
            ]);

            // Get all candidates in the same category
            $candidates = Candidate::where('category_id', $candidate->category_id)
                ->orderBy('order')
                ->get();

            // Find the candidate to swap with
            $newOrder = $validatedData['order'];
            $oldOrder = $candidate->order;

            // Reorder candidates
            if ($newOrder < $oldOrder) {
                // Moving up: increment all between new and old position
                Candidate::where('category_id', $candidate->category_id)
                    ->where('order', '>=', $newOrder)
                    ->where('order', '<', $oldOrder)
                    ->increment('order');
            } else if ($newOrder > $oldOrder) {
                // Moving down: decrement all between old and new position
                Candidate::where('category_id', $candidate->category_id)
                    ->where('order', '>', $oldOrder)
                    ->where('order', '<=', $newOrder)
                    ->decrement('order');
            }

            // Set the new order for this candidate
            $candidate->order = $newOrder;
            $candidate->save();

            return redirect()->back()->with('success', 'Candidate order updated successfully.');
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Failed to update candidate order: ' . $e->getMessage());
        }
    }

    /**
     * Update the status of a candidate.
     */
    public function updateStatus(Request $request, Candidate $candidate)
    {
        try {
            $validatedData = $request->validate([
                'status' => 'required|in:active,inactive',
            ]);

            $candidate->status = $validatedData['status'];
            $candidate->save();

            return redirect()->back()->with('success', 'Candidate status updated successfully.');
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Failed to update candidate status: ' . $e->getMessage());
        }
    }

    /**
     * Remove the specified candidate from storage.
     */
    public function destroy(Candidate $candidate)
    {
        try {
            // Delete image if exists

            if (file_exists($candidate->image)) {
                unlink($candidate->image);
            }

            // Get the candidate's order
            $deletedOrder = $candidate->order;
            $categoryId = $candidate->category_id;

            // Delete the candidate
            $candidate->delete();

            // Reorder remaining candidates
            Candidate::where('category_id', $categoryId)
                ->where('order', '>', $deletedOrder)
                ->decrement('order');

            return redirect()->back()->with('success', 'Candidate deleted successfully.');
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'An error occurred while deleting the Candidate.');
        }
    }
}
