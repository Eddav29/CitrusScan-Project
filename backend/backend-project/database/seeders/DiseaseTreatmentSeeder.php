<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class DiseaseTreatmentSeeder extends Seeder
{
    public function run(): void
    {
        $diseases = DB::table('diseases')->pluck('id', 'name');

        DB::table('disease_treatments')->insert([
            [
                'id' => Str::uuid(),
                'disease_id' => $diseases['Black Spot'],
                'step' => 1,
                'action' => 'Prune affected branches to remove infected material.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => Str::uuid(),
                'disease_id' => $diseases['Black Spot'],
                'step' => 2,
                'action' => 'Apply fungicide spray to prevent further spread.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => Str::uuid(),
                'disease_id' => $diseases['Greening'],
                'step' => 1,
                'action' => 'Use insecticides to control psyllid population.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Tambahkan langkah lain sesuai kebutuhan
        ]);
    }
}
