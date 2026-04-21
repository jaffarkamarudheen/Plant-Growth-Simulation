<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('simulations', function (Blueprint $table) {
            $table->id();
            $table->string('plant_name')->default('Succulent');
            $table->integer('current_day')->default(0);
            $table->float('growth_percentage')->default(0);
            $table->float('health_percentage')->default(100);
            $table->float('last_water_level')->default(50);
            $table->float('last_sunlight_level')->default(50);
            $table->enum('status', ['growing', 'matured', 'withered', 'dead'])->default('growing');
            $table->json('history')->nullable(); // To store daily stats for charts
            $table->timestamps();
        });

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('simulations');
    }
};
