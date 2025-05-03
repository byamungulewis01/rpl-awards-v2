<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    use HasFactory;

    protected $fillable = [
        'candidate_id',
        'phone_number',
        'payment_method',
        'amount',
        'votes',
        'status',
        'transaction_id',
        'payment_details',
    ];

    protected $casts = [
        'payment_details' => 'array',
    ];

    public function candidate()
    {
        return $this->belongsTo(Candidate::class);
    }

    public function votes()
    {
        return $this->hasMany(Vote::class);
    }
}
