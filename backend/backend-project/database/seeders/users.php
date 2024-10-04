<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Database\Seeders\detections;
use Database\Seeders\history;

class Users extends Seeder
{
    public function run()
    {
        // Insert user dan simpan UUID untuk referensi foreign key
        DB::table('users')->insert([
            [
                'user_id' =>Str::uuid(),
                'name' => 'user1',
                'email' => 'user1@example.com',
                'password' => bcrypt('user1'),
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'user_id' => Str::uuid(),
                'name' => 'user2',
                'email' => 'user@example.com',
                'password' => bcrypt('puser'),
                'created_at' => now(),
                'updated_at' => now(),
            ]
        ]);

        // Simpan UUID di seeder detections dan history
    }
}