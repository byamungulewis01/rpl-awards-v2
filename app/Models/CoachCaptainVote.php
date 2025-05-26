<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CoachCaptainVote extends Model
{
    //
    protected $fillable = [
        'candidate_id',
        'category_id',
        'user_id',
    ];

    public function candidate()
    {
        return $this->belongsTo(Candidate::class);
    }

    public function category()
    {
        return $this->belongsTo(Category::class);
    }
}
