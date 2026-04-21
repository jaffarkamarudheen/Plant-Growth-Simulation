<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class UpdatePlantGrowth extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'plants:grow';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Updates growth percentage and stages for all user plants';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $controller = new \App\Http\Controllers\PlantController();
        $result = $controller->updateGrowth();
        $this->info($result);
    }
}
