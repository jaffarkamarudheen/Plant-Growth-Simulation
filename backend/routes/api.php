<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\SimulationController;
use App\Http\Controllers\PlantController;

Route::apiResource('simulations', SimulationController::class);
Route::post('simulations/{simulation}/reset', [SimulationController::class, 'reset']);

Route::apiResource('plants', PlantController::class);
Route::post('/plant/select', [PlantController::class, 'select']);
Route::post('/plant/care', [PlantController::class, 'care']);
Route::get('/plant/status', [PlantController::class, 'status']);
Route::delete('/plant/user-plant/{id}', [PlantController::class, 'destroyUserPlant']);
Route::post('/plant/update-growth', [PlantController::class, 'updateGrowth']);

