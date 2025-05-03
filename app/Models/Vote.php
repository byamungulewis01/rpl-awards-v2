<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vote extends Model
{
    use HasFactory;

    protected $fillable = [
        'candidate_id',
        'payment_id',
    ];

    public function candidate()
    {
        return $this->belongsTo(Candidate::class);
    }

    public function payment()
    {
        return $this->belongsTo(Payment::class);
    }
}
