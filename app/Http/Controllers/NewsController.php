<?php

namespace App\Http\Controllers;

use App\Models\News;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Illuminate\Support\Facades\Storage;

class NewsController extends Controller
{
    public function index()
    {
        try {
            $news = News::latest()->get();
            return Inertia::render('News/Index', [
                'news' => $news
            ]);
        } catch (\Exception $e) {
            return redirect()->back()
                ->with('error', 'Error loading news articles: ' . $e->getMessage());
        }
    }


    public function create()
    {
        try {
            return Inertia::render('News/Create');
        } catch (\Exception $e) {
            return redirect()->back()
                ->with('error', 'Error loading create form: ' . $e->getMessage());
        }
    }

    public function store(Request $request)
    {
        try {
            $validated = $request->validate([
                'title' => 'required|string|max:255',
                'image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
                'short_description' => 'required|string|max:1000',
                'long_description' => 'required|string',
            ]);

            // Handle image upload
            if ($request->hasFile('image')) {
                $image = $request->file('image');
                $imageName = time() . '_' . $image->getClientOriginalName();
                $image->move('news', $imageName);
                $validated['image'] = "/news/{$imageName}";
            }

            $validated['slug'] = Str::slug($validated['title']);

            News::create($validated);

            return redirect()->route('news.index')
                ->with('success', 'News article created successfully.');

        } catch (\Exception $e) {
            return redirect()->back()
                ->with('error', 'Error creating news article: ' . $e->getMessage())
                ->withInput();
        }
    }

    public function edit($id)
    {
        try {
            $news = News::findOrFail($id);
            return Inertia::render('News/Edit', [
                'article' => $news
            ]);
        } catch (\Exception $e) {
            return redirect()->back()
                ->with('error', 'Error loading edit form: ' . $e->getMessage());
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $news = News::findOrFail($id);
            $validated = $request->validate([
                'title' => 'required|string|max:255',
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                'short_description' => 'required|string|max:1000',
                'long_description' => 'required|string',
            ]);
            // Handle image upload if new image is provided
            if ($request->hasFile('image')) {
                // Delete old image
                if (file_exists($news->image)) {
                    unlink($news->image);
                }

                $image = $request->file('image');
                $imageName = time() . '_' . $image->getClientOriginalName();
                $image->move('news', $imageName);
                $validated['image'] = "/news/{$imageName}";
            } else {
                $validated['image'] = $news->image;
            }

            $validated['slug'] = Str::slug($validated['title']);

            $news->update($validated);

            return redirect()->route('news.index')
                ->with('success', 'News article updated successfully.');

        } catch (\Exception $e) {
            return redirect()->back()
                ->with('error', 'Error updating news article: ' . $e->getMessage())
                ->withInput();
        }
    }

    public function destroy($id)
    {
        try {
            $news = News::findOrFail($id);
            // Delete the image file
            if (file_exists($news->image)) {
                unlink($news->image);
            }

            $news->delete();

            return redirect()->route('news.index')
                ->with('success', 'News article deleted successfully.');

        } catch (\Exception $e) {
            return redirect()->back()
                ->with('error', 'Error deleting news article: ' . $e->getMessage());
        }
    }
}
