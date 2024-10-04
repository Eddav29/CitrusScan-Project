<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class Detection extends Seeder
{
    public function run()
    {   
        // Mendapatkan user_id dari tabel users
        $users = DB::table('users')->pluck('user_id'); // ambil UUID

        foreach ($users as $user_id) {
            // Gunakan UUID dari users sebagai foreign key
            DB::table('detections')->insert([
                [
                    'detection_id' => Str::uuid(),
                    'user_id' => $user_id, // UUID dari seeder users
                    'image_url' => 'sample1.png',
                    'disease_detected' => 'Citrus Greening',
                    'recommendation' => 'Trim infected areas and apply pesticide.',
                    'created_at' => now(),
                    'updated_at' => now(),
                ],
                [
                    'detection_id' => Str::uuid(),
                    'user_id' => $user_id, // UUID dari seeder users
                    'image_url' => 'sample2.png',
                    'disease_detected' => 'Leaf Spot',
                    'recommendation' => 'Remove affected leaves and avoid overhead watering.',
                    'created_at' => now(),
                    'updated_at' => now(),
                ]
            ]);
        }
    }
}
