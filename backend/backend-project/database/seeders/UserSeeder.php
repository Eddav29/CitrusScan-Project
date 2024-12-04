<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class UserSeeder extends Seeder
{
    public function run()
    {
        $users = [
            [
                'name' => 'user1',
                'email' => 'user1@example.com',
                'password' => bcrypt('user1'),
            ],
            [
                'name' => 'user2',
                'email' => 'user@example.com',
                'password' => bcrypt('puser'),
            ]
        ];

        foreach ($users as $user) {
            DB::table('users')->insert([
                'user_id' => Str::uuid(),
                'name' => $user['name'],
                'email' => $user['email'],
                'password' => $user['password'],
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        // Simpan UUID di seeder detections dan history
    }
}