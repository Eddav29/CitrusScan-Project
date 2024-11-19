<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class PredictionSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('predictions')->insert([
            [
                'id' => Str::uuid(),
                'predicted_class' => 'Greening',
                'confidence' => 0.95,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => Str::uuid(),
                'predicted_class' => 'Black Spot',
                'confidence' => 0.85,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
