<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Candidate extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'category_id',
        'name',
        'image',
        'order',
        'status',
        'stats',
    ];

    protected $casts = [
        'order' => 'integer',
        'stats' => 'array',
    ];

    /**
     * Get the category that owns the candidate.
     */
    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function votes()
    {
        return $this->hasMany(Vote::class);
    }

    public function getVotesCountAttribute()
    {
        return $this->votes()->count();
    }

}
