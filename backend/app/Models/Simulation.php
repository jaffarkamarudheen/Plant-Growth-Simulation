<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Simulation extends Model
{
    protected $fillable = [
        'plant_name',
        'current_day',
        'growth_percentage',
        'health_percentage',
        'last_water_level',
        'last_sunlight_level',
        'status',
        'history'
    ];

    protected $casts = [
        'history' => 'array',
        'growth_percentage' => 'float',
        'health_percentage' => 'float',
        'last_water_level' => 'float',
        'last_sunlight_level' => 'float',
    ];
}
