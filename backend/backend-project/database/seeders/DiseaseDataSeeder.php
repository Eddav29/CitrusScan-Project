<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class DiseaseDataSeeder extends Seeder
{
    public function run()
    {
        DB::table('citrus_disease_data')->insert([
            [
                'disease_id' => Str::uuid(),
                'disease_name' => 'Healthy',
                'description' => 'No disease, healthy citrus.',
                'symptoms' => '',
                'prevention' => ''
            ],
            [
                'disease_id' => Str::uuid(),
                'disease_name' => 'Citrus Canker',
                'description' => 'Bacterial disease causing lesions on leaves, stems, and fruit.',
                'symptoms' => 'Lesions on leaves, stems, and fruit.',
                'prevention' => 'Use of copper-based bactericides.'
            ],
            [
                'disease_id' => Str::uuid(),
                'disease_name' => 'Citrus Greening',
                'description' => 'Bacterial disease causing yellow shoots and misshapen fruit.',
                'symptoms' => 'Yellow shoots, misshapen fruit.',
                'prevention' => 'Removal of infected trees.'
            ],
            [
                'disease_id' => Str::uuid(),
                'disease_name' => 'Citrus Black Spot',
                'description' => 'Fungal disease causing black spots on fruit.',
                'symptoms' => 'Black spots on fruit.',
                'prevention' => 'Fungicide application.'
            ],
            [
                'disease_id' => Str::uuid(),
                'disease_name' => 'Citrus Scab',
                'description' => 'Fungal disease causing scab-like lesions on fruit and leaves.',
                'symptoms' => 'Scab-like lesions on fruit and leaves.',
                'prevention' => 'Use of resistant varieties.'
            ],
        ]);
    }
}