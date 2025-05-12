<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('candidate_id')->constrained()->onDelete('cascade');
            $table->foreignId('category_id')->constrained()->onDelete('cascade');
            $table->string('phone_number', 20);
            $table->string('payment_method', 20); // mtn, airtel, etc.
            $table->integer('amount');
            $table->integer('votes');
            $table->string('status', 20)->default('pending'); // pending, initiated, completed, failed
            $table->string('transaction_id')->unique()->nullable();
            $table->json('payment_details')->nullable(); // For storing payment gateway response
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
