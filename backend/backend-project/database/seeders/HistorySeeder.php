<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class HistorySeeder extends Seeder
{
    public function run()
    {
        // Mengambil UUID dari users dan detections
        $users = DB::table('users')->pluck('user_id'); // ambil UUID pengguna
        $detections = DB::table('detections')->pluck('detection_id'); // ambil UUID deteksi

        // Pastikan ada cukup data untuk di-insert
        if ($users->count() >= 2 && $detections->count() >= 2) {
            DB::table('history')->insert([
                [
                    'history_id' => Str::uuid(),
                    'user_id' => $users[0], // UUID dari user pertama
                    'detection_id' => $detections[0], // UUID dari deteksi pertama
                    'saved_at' => now(),
                    'created_at' => now(),
                    'updated_at' => now(),
                ],
                [
                    'history_id' => Str::uuid(),
                    'user_id' => $users[1], // UUID dari user kedua
                    'detection_id' => $detections[1], // UUID dari deteksi kedua
                    'saved_at' => now(),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]
            ]);
        }
    }
}
