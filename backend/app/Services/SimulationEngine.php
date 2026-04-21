<?php

namespace App\Services;

use App\Models\Simulation;

class SimulationEngine
{
    /**
     * The Rule System is designed to be modular.
     * New logic (e.g., Nutrients, Pests) can be added as separate methods
     * called within the processStep pipeline.
     */
    public function processStep(Simulation $simulation, float $sunlight, float $water): Simulation
    {
        if ($simulation->status === 'dead') {
            return $simulation;
        }

        $simulation->current_day++;
        
        // 1. Calculate Environmental Stress
        $stressChange = $this->calculateStress($sunlight, $water);
        
        // 2. Update Health based on Stress and Conditions
        $this->updateHealth($simulation, $stressChange, $sunlight, $water);
        
        // 3. Update Growth based on current Health
        $this->updateGrowth($simulation, $sunlight, $water);
        
        // 4. Update Status (Lifecycle management)
        $this->updateStatus($simulation);

        // 5. Store State History (Cumulative Effects)
        $this->recordHistory($simulation, $sunlight, $water);

        $simulation->save();
        return $simulation;
    }

    private function calculateStress(float $sunlight, float $water): float
    {
        $stress = 0;
        
        // Rule: Low water + High sunlight -> High Stress
        if ($water < 30 && $sunlight > 70) $stress += 15;
        
        // Rule: High water + Low sunlight -> Root Rot Risk (Stress)
        if ($water > 80 && $sunlight < 30) $stress += 10;
        
        // Rule: Balanced conditions -> Stress Recovery
        if ($water >= 40 && $water <= 70 && $sunlight >= 40 && $sunlight <= 80) $stress -= 5;

        return $stress;
    }

    private function updateHealth(Simulation $simulation, float $stressChange, float $sunlight, float $water): void
    {
        // Cumulative health impact
        $healthImpact = -$stressChange;
        
        // Bonus for optimal conditions
        if ($water >= 50 && $water <= 70 && $sunlight >= 50 && $sunlight <= 80) {
            $healthImpact += 5;
        }

        $simulation->health_percentage = max(0, min(100, $simulation->health_percentage + $healthImpact));
    }

    private function updateGrowth(Simulation $simulation, float $sunlight, float $water): void
    {
        if ($simulation->health_percentage < 20) return; // Stunted growth

        $baseGrowth = ($simulation->health_percentage / 100) * 4;
        
        // Boost for consistent optimal conditions
        if ($water >= 50 && $water <= 70 && $sunlight >= 50 && $sunlight <= 80) {
            $baseGrowth *= 1.5;
        }

        $simulation->growth_percentage = min(100, $simulation->growth_percentage + $baseGrowth);
    }

    private function updateStatus(Simulation $simulation): void
    {
        if ($simulation->health_percentage <= 0) {
            $simulation->status = 'dead';
        } elseif ($simulation->health_percentage < 30) {
            $simulation->status = 'withered'; // "Plant Stress" state
        } elseif ($simulation->growth_percentage >= 100) {
            $simulation->status = 'matured';
        } else {
            $simulation->status = 'growing';
        }
    }

    private function recordHistory(Simulation $simulation, float $sunlight, float $water): void
    {
        $history = $simulation->history ?? [];
        $history[] = [
            'day' => $simulation->current_day,
            'sunlight' => $sunlight,
            'water' => $water,
            'health' => $simulation->health_percentage,
            'growth' => $simulation->growth_percentage,
            'status' => $simulation->status,
            'timestamp' => now()
        ];
        $simulation->history = $history;
    }
}
