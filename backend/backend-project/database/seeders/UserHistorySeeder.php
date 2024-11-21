<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class UserHistorySeeder extends Seeder
{
    public function run()
    {
        $users = DB::table('users')->pluck('user_id');
        $predictions = DB::table('predictions')->pluck('prediction_id');

        foreach ($users as $user_id) {
            foreach ($predictions as $prediction_id) {
                DB::table('user_histories')->insert([
                    'user_histories_id' => Str::uuid(),
                    'user_id' => $user_id,
                    'prediction_id' => $prediction_id,
                    'image_path' => 'path/to/image.jpg',
                    'created_at' => now(),
                ]);
            }
        }
    }
}