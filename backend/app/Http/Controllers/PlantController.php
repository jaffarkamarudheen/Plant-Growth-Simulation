<?php

namespace App\Http\Controllers;

use App\Models\Plant;
use App\Models\UserPlant;
use Illuminate\Http\Request;
use Carbon\Carbon;

class PlantController extends Controller
{
    public function index()
    {
        return response()->json(Plant::all());
    }

    public function select(Request $request)
    {
        $request->validate([
            'plant_id' => 'required|exists:plants,id',
        ]);

        // For simplicity, we'll use user_id 1 if not authenticated
        $userId = auth()->id() ?? 1;

        $userPlant = UserPlant::create([
            'user_id' => $userId,
            'plant_id' => $request->plant_id,
            'planted_at' => now(),
            'growth_percentage' => 0,
            'growth_stage' => 'Seed',
            'health' => 100,
        ]);

        return response()->json($userPlant->load('plant'));
    }

    public function care(Request $request)
    {
        $request->validate([
            'user_plant_id' => 'required|exists:user_plants,id',
            'type' => 'required|in:water,sunlight',
            'level' => 'required|in:low,medium,high',
        ]);

        $userPlant = UserPlant::findOrFail($request->user_plant_id);

        if ($request->type === 'water') {
            $userPlant->last_watered_at = now();
            $userPlant->current_water_level = $request->level;
        } else {
            $userPlant->last_sunlight_at = now();
            $userPlant->current_sunlight_level = $request->level;
        }

        $userPlant->save();

        return response()->json($userPlant);
    }

    public function status(Request $request)
    {
        $userId = auth()->id() ?? 1;
        $userPlants = UserPlant::with('plant')
            ->where('user_id', $userId)
            ->get();

        return response()->json($userPlants);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string',
            'category' => 'required|in:small,medium,tree',
            'base_growth_days' => 'required|integer|min:1',
            'water_requirement' => 'required|in:low,medium,high',
            'sunlight_requirement' => 'required|in:low,medium,high',
        ]);

        $plant = Plant::create($data);
        return response()->json($plant);
    }

    public function update(Request $request, Plant $plant)
    {
        $data = $request->validate([
            'name' => 'string',
            'category' => 'in:small,medium,tree',
            'base_growth_days' => 'integer|min:1',
            'water_requirement' => 'in:low,medium,high',
            'sunlight_requirement' => 'in:low,medium,high',
        ]);

        $plant->update($data);
        return response()->json($plant);
    }

    public function destroy(Plant $plant)
    {
        $plant->delete();
        return response()->json(['message' => 'Plant deleted']);
    }

    public function destroyUserPlant($id)
    {
        $userPlant = UserPlant::findOrFail($id);
        $userPlant->delete();
        return response()->json(['message' => 'Plant removed from garden']);
    }

    /**
     * This method would be called by a scheduled task.
     * It updates growth for all plants.
     */
    public function updateGrowth()
    {
        $userPlants = UserPlant::with('plant')->get();

        foreach ($userPlants as $userPlant) {
            $plant = $userPlant->plant;
            
            // Care Factors
            $waterFactor = 0.0;
            if ($userPlant->current_water_level === $plant->water_requirement) {
                $waterFactor = 1.0;
            }

            $sunlightFactor = 0.0;
            if ($userPlant->current_sunlight_level === $plant->sunlight_requirement) {
                $sunlightFactor = 1.0;
            }

            // Category Multiplier
            $categoryMultiplier = 1.0;
            if ($plant->category === 'small') {
                $categoryMultiplier = 1.2;
            } elseif ($plant->category === 'tree') {
                $categoryMultiplier = 0.5;
            }

            // Effective Growth (User says: effective_growth = days_passed * water_factor * sunlight_factor)
            // But usually we want to increment.
            // Requirement 8: "update growth daily"
            // So we add to the current progress.
            
            // Standard daily increment if factors are 1.0: 100 / base_growth_days
            $dailyIncrement = (100 / $plant->base_growth_days);
            $effectiveIncrement = $dailyIncrement * $waterFactor * $sunlightFactor * $categoryMultiplier;

            $userPlant->growth_percentage = min(100, $userPlant->growth_percentage + $effectiveIncrement);
            $userPlant->age_days += 1;

            // Update Stage
            if ($userPlant->growth_percentage <= 25) {
                $userPlant->growth_stage = 'Seed';
            } elseif ($userPlant->growth_percentage <= 50) {
                $userPlant->growth_stage = 'Sprout';
            } elseif ($userPlant->growth_percentage <= 80) {
                $userPlant->growth_stage = 'Growing';
            } else {
                $userPlant->growth_stage = 'Mature';
            }

            // Health logic (Optional but good)
            if ($waterFactor < 1.0 || $sunlightFactor < 1.0) {
                $userPlant->health = max(0, $userPlant->health - 5);
            } else {
                $userPlant->health = min(100, $userPlant->health + 5);
            }

            // History tracking
            $history = $userPlant->history ?? [];
            $history[] = [
                'day' => $userPlant->age_days,
                'growth' => round($userPlant->growth_percentage, 1),
                'health' => $userPlant->health,
            ];
            $userPlant->history = $history;

            $userPlant->save();
        }

        return count($userPlants) . " plants updated.";
    }
}
