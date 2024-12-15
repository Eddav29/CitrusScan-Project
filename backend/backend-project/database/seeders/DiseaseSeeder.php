<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class DiseaseSeeder extends Seeder
{
    public function run()
    {
        $diseases = [
            [
                'name' => 'Black Spot',
                'treatment' => 'Gunakan fungisida berbasis tembaga setiap 2 minggu selama musim hujan.',
                'disease_image' => 'uploads/black-spot.jpg',
            ],
            [
                'name' => 'Greening',
                'treatment' => 'Kontrol kutu loncat dengan insektisida, dan cabut tanaman yang terinfeksi parah.',
                'disease_image' => 'uploads/greening.jpg',
            ],
            [
                'name' => 'Cancer',
                'treatment' => 'Aplikasikan bakterisida berbasis tembaga dan pangkas bagian yang terinfeksi.',
                'disease_image' => 'uploads/cancer.jpg',
            ],
            [
                'name' => 'Melanose',
                'treatment' => 'Lakukan pemangkasan cabang mati dan aplikasikan fungisida sebelum pembentukan buah.',
                'disease_image' => 'uploads/melanose.jpg',
            ],
            [
                'name' => 'Healthy',
                'description' => 'Tanaman yang sehat.',
                'disease_image' => 'uploads/healthy.jpg',
            ],
            [
                'name' => 'Non Citrus Leaf',
                'description' => 'Tanaman yang bukan tanaman jeruk.',
                'treatment' => 'Tidak ada rawatan khusus.',
            ],
        ];
    
        foreach ($diseases as $disease) {
            DB::table('diseases')->insert([
                'disease_id' => Str::uuid(),
                'name' => $disease['name'],
                'treatment' => $disease['treatment'],
                'disease_image' => $disease['disease_image'],
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }  
}
