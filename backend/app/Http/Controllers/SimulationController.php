<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Simulation;
use App\Services\SimulationEngine;


class SimulationController extends Controller
{
    protected $engine;

    public function __construct(SimulationEngine $engine)
    {
        $this->engine = $engine;
    }

    public function index()
    {
        return Simulation::all();
    }

    public function store(Request $request)
    {
        $request->validate([
            'plant_name' => 'required|string|max:191'
        ]);

        return Simulation::create([
            'plant_name' => $request->plant_name,
            'current_day' => 0,
            'growth_percentage' => 0,
            'health_percentage' => 100,
            'status' => 'growing',
            'history' => []
        ]);
    }

    public function show(Simulation $simulation)
    {
        return $simulation;
    }

    public function update(Request $request, Simulation $simulation)
    {
        $request->validate([
            'sunlight' => 'required|numeric|min:0|max:100',
            'water' => 'required|numeric|min:0|max:100'
        ]);

        return $this->engine->processStep(
            $simulation,
            (float) $request->sunlight,
            (float) $request->water
        );
    }

    public function destroy(Simulation $simulation)
    {
        $simulation->delete();
        return response()->json(['message' => 'Simulation deleted']);
    }

    public function reset(Simulation $simulation)
    {
        $simulation->update([
            'current_day' => 0,
            'growth_percentage' => 0,
            'health_percentage' => 100,
            'status' => 'growing',
            'history' => []
        ]);
        return $simulation;
    }
}

