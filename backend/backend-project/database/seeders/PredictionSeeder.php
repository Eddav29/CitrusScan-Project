<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class PredictionSeeder extends Seeder
{
    public function run()
    {
        $diseases = DB::table('diseases')->pluck('disease_id');

        for ($i = 1; $i <= 5; $i++) {
            DB::table('predictions')->insert([
                'prediction_id' => Str::uuid(),
                'disease_id' => $diseases->random(),
                'second_best_disease' => $diseases->random(),
                'confidence' => rand(70, 100) / 100,
                'second_best_disease_confidence' => rand(50, 69) / 100,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}