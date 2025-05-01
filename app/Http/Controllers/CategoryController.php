<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\League;
use App\Models\Category;
use App\Models\Candidate;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class CategoryController extends Controller
{
    /**
     * Display a listing of categories with league tabs.
     */
    public function index()
    {
        return Inertia::render('Categories/Index', [
            'categories' => Category::withCount('candidates')->get(),
        ]);
    }
    public function show(Category $category)
    {
        return Inertia::render('Categories/Candidates', [
            'category' => $category,
            'candidates' => $category->candidates()->get(),
        ]);
    }


    /**
     * Store a newly created Category.
     */
    public function store(Request $request)
    {
        try {
            $request->validate([
                'name' => [
                    'required',
                    'string',
                    'max:255',
                    Rule::unique('categories')->where(function ($query) use ($request) {
                        return $query->where('name', $request->name)
                            ->where('league', $request->league);
                    }),
                ],
                'league' => 'required|in:men,women',
                'description' => 'nullable|string|max:255',
            ]);


            Category::create($request->all());

            return redirect()->back()->with('success', 'Category created successfully.');
        } catch (\Illuminate\Validation\ValidationException $e) {
            // This will automatically handle validation errors and return them to the form
            throw $e;
        } catch (\Exception $e) {
            dd($e->getMessage());
            return redirect()->back()
                ->withInput()
                ->withErrors(['error' => 'Failed to create Category: ' . $e->getMessage()]);
        }
    }

    /**
     * Update the specified Category.
     */
    public function update(Request $request, Category $category)
    {
        try {
            $request->validate([
                'name' => [
                    'required',
                    'string',
                    'max:255',
                    Rule::unique('categories')->where(function ($query) use ($request) {
                        return $query->where('name', $request->name)
                            ->where('league', $request->league);
                    })->ignore($category->id),
                ],
                'league' => 'required|in:men,women',
                'description' => 'nullable|string|max:255',

            ]);

            $category->update($request->all());

            return redirect()->back()->with('success', 'Category updated successfully.');
        } catch (\Illuminate\Validation\ValidationException $e) {
            throw $e;
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'An error occurred while updating the Category.');
        }
    }

    /**
     * Remove the specified Category from storage.
     */
    public function destroy(Category $category)
    {
        try {
            $category->delete();
            return redirect()->back()->with('success', 'Category deleted successfully.');
        } catch (\Exception $e) {
            if ($e->getCode() === '23000') {
                return redirect()->back()->with(['error' => 'Failed to delete Category: Category has related data.']);
            }
            return redirect()->back()->with('error', 'An error occurred while deleting the Category.');
        }
    }

    private function generateUniqueCode()
    {
        do {
            $code = str_pad(random_int(1, 999), 3, '0', STR_PAD_LEFT);
        } while (Candidate::where('code', $code)->exists());

        return $code;
    }


}
