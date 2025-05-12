<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UssdController;
use App\Http\Controllers\PaymentController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('ussd', [UssdController::class, 'index']);

Route::post('/payments/webhook', [PaymentController::class, 'handleWebhook']);

Route::get('/test-sms', [PaymentController::class, 'test_sms']);