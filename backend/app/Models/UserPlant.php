<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserPlant extends Model
{
    protected $fillable = [
        'user_id',
        'plant_id',
        'planted_at',
        'growth_percentage',
        'growth_stage',
        'health',
        'last_watered_at',
        'last_sunlight_at',
        'history',
        'age_days',
        'current_water_level',
        'current_sunlight_level',
    ];

    protected $casts = [
        'planted_at' => 'datetime',
        'last_watered_at' => 'datetime',
        'last_sunlight_at' => 'datetime',
        'growth_percentage' => 'float',
        'history' => 'array',
    ];

    public function plant()
    {
        return $this->belongsTo(Plant::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
