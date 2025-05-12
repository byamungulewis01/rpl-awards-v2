<?php

namespace App\Http\Controllers;

use App\Models\News;
use Inertia\Inertia;

class WelcomeController extends Controller
{
    public function index()
    {
        $news = News::latest()->take(3)->get();

        return Inertia::render('Welcome', [
            'news' => $news,
            'vote_amount' => 200
        ]);
    }
}
