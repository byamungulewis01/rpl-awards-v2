<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class USSDSession extends Model
{

    protected $table = 'ussd_sessions';
    protected $fillable = [
        'phone_number',
        'level',
        'data',
        'last_activity'
    ];

    protected $casts = [
        'data' => 'array',
        'last_activity' => 'datetime'
    ];
}
