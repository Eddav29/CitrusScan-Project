<?php

namespace Database\Seeders;


// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Database\Seeders\UserSeeder;
use Database\Seeders\DetectionsSeeder;
use Database\Seeders\HistorySeeder;
use Database\Seeders\DiseaseDataSeeder;
class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        $this->call(UserSeeder::class);
        $this->call(DetectionsSeeder::class);
        $this->call(HistorySeeder::class);
        $this->call([
            DiseaseSeeder::class,
            DiseaseTreatmentSeeder::class,
            PredictionSeeder::class,
            AllProbabilitiesSeeder::class,
        ]);
    }
}
