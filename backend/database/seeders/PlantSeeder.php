<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class PlantSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $user = \App\Models\User::firstOrCreate(
            ['email' => 'user@example.com'],
            ['name' => 'Default User', 'password' => \Hash::make('password')]
        );

        \DB::table('plants')->insert([
            [
                'name' => 'Aloe Vera',
                'category' => 'small',
                'base_growth_days' => 45,
                'water_requirement' => 'low',
                'sunlight_requirement' => 'high',
            ],
            [
                'name' => 'Tomato',
                'category' => 'medium',
                'base_growth_days' => 120,
                'water_requirement' => 'medium',
                'sunlight_requirement' => 'high',
            ],
            [
                'name' => 'Oak Tree',
                'category' => 'tree',
                'base_growth_days' => 1825,
                'water_requirement' => 'medium',
                'sunlight_requirement' => 'medium',
            ],
        ]);
    }
}
