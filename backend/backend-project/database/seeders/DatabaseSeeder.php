<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Database\Seeders\users;
use Database\Seeders\Detection;
use Database\Seeders\History;

class DatabaseSeeder extends Seeder
{
    public function run()
    {
        // Panggil seeder untuk tabel users jika ada
        $this->call(Users::class);
        $this->call(Detection::class);
        $this->call(History::class);
    }
}
