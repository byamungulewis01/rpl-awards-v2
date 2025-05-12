<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    //
    protected $fillable = [
        'league', //men , women
        'name',
        'description',
        'status',
    ];

    /**
     * Get the candidates for the category.
     */
    public function candidates()
    {
        return $this->hasMany(Candidate::class);
    }


}
