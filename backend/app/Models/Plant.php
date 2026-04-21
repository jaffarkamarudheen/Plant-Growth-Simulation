<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Plant extends Model
{
    protected $fillable = [
        'name',
        'category',
        'base_growth_days',
        'water_requirement',
        'sunlight_requirement',
    ];
}
