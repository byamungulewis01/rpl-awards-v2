<?php

use App\Http\Controllers\VotingController;
use Inertia\Inertia;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CandidateController;
use App\Http\Controllers\Admin\AdminNominationController;


// Route::get('/', function () {
//     return Inertia::render('Welcome', );
// });

Route::get('/', [VotingController::class, 'index'])->name('voting.index');
Route::post('/process-payment', [VotingController::class, 'processPayment'])->name('voting.process');

Route::middleware(['auth', 'verified', 'track-last-login', 'active-user'])->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Dashboard');
    })->name('dashboard');

    Route::middleware('user-access:super_admin,admin')->group(function () {
        Route::resource('users', UserController::class);
        Route::resource('categories', CategoryController::class);

        Route::post('/candidates', [CandidateController::class, 'store'])->name('candidates.store');
        Route::post('/candidates/{candidate}', [CandidateController::class, 'update'])->name('candidates.update');
        Route::delete('/candidates/{candidate}', [CandidateController::class, 'destroy'])->name('candidates.destroy');

        // New routes for order and status updates
        Route::post('/candidates/{candidate}/order', [CandidateController::class, 'updateOrder'])->name('candidates.updateOrder');
        Route::post('/candidates/{candidate}/status', [CandidateController::class, 'updateStatus'])->name('candidates.updateStatus');


        // Route::prefix('admin')->name('admin.')->group(function () {
        //     // Nomination statistics and analytics
        //     Route::get('/nominations/stats', [AdminNominationController::class, 'index'])->name('nominations.stats');
        //     Route::get('/nominations/candidate/{id}', [AdminNominationController::class, 'candidateDetail'])->name('nominations.candidate-detail');
    });


    Route::get('/admin/nominations/dashboard', [AdminNominationController::class, 'dashboard'])
        ->name('admin.nominations.dashboard');

    // Export voting data
    Route::get('/admin/nominations/export', [AdminNominationController::class, 'exportVotingData'])
        ->name('admin.nominations.export');


    // Profile
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    ;


});

require __DIR__ . '/auth.php';
