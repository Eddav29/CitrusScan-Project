<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class DiseaseSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('diseases')->insert([
            [
                'id' => Str::uuid(),
                'name' => 'Black Spot',
                'description' => 'Penyakit jamur yang menyebabkan bintik hitam pada daun jeruk.',
                'treatment' => 'Hapus daun yang terkena dan gunakan semprotan fungisida.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => Str::uuid(),
                'name' => 'Melanose',
                'description' => 'Penyakit jamur yang menyebabkan bintik coklat gelap yang menonjol.',
                'treatment' => 'Pangkas cabang yang terinfeksi dan aplikasikan semprotan berbasis tembaga.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => Str::uuid(),
                'name' => 'Canker',
                'description' => 'Penyakit bakteri yang menyebabkan lesi berkerak pada daun dan buah.',
                'treatment' => 'Hapus area yang terinfeksi dan aplikasikan bakterisida.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => Str::uuid(),
                'name' => 'Greening',
                'description' => 'Penyakit bakteri yang disebarkan oleh psyllid menyebabkan daun menguning.',
                'treatment' => 'Kendalikan populasi psyllid dan gunakan bibit bebas penyakit.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => Str::uuid(),
                'name' => 'Healthy',
                'description' => 'Tidak ada penyakit terdeteksi, tanaman dalam kondisi sehat.',
                'treatment' => 'Lanjutkan pemeliharaan dan pemantauan rutin.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}

