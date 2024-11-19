<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class AllProbabilitiesSeeder extends Seeder
{
    public function run(): void
    {
        $predictions = DB::table('predictions')->pluck('id', 'predicted_class');

        DB::table('all_probabilities')->insert([
            [
                'id' => Str::uuid(),
                'prediction_id' => $predictions['Greening'],
                'disease_name' => 'Greening',
                'probability' => 0.95,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => Str::uuid(),
                'prediction_id' => $predictions['Greening'],
                'disease_name' => 'Black Spot',
                'probability' => 0.01,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Tambahkan probabilitas lainnya sesuai kebutuhan
        ]);
    }
}
