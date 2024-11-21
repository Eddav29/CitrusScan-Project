<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class DiseaseSeeder extends Seeder
{
    public function run()
    {
        DB::table('diseases')->insert([
            [
                'disease_id' => Str::uuid(),
                'name' => 'Citrus Black Spot',
                'description' => 'Disebabkan oleh jamur *Phyllosticta citricarpa*, ditandai dengan bintik hitam pada buah dan daun.',
                'treatment' => 'Gunakan fungisida berbasis tembaga setiap 2 minggu selama musim hujan.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'disease_id' => Str::uuid(),
                'name' => 'Citrus Greening (HLB)',
                'description' => 'Disebabkan oleh bakteri *Candidatus Liberibacter*, yang disebarkan oleh kutu loncat.',
                'treatment' => 'Kontrol kutu loncat dengan insektisida, dan cabut tanaman yang terinfeksi parah.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'disease_id' => Str::uuid(),
                'name' => 'Citrus Canker',
                'description' => 'Infeksi bakteri *Xanthomonas citri* yang menyebabkan lesi dan luka pada daun, batang, dan buah.',
                'treatment' => 'Aplikasikan bakterisida berbasis tembaga dan pangkas bagian yang terinfeksi.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'disease_id' => Str::uuid(),
                'name' => 'Citrus Melanose',
                'description' => 'Penyakit jamur yang disebabkan oleh *Diaporthe citri*, menyebabkan bintik coklat kecil pada daun dan buah.',
                'treatment' => 'Lakukan pemangkasan cabang mati dan aplikasikan fungisida sebelum pembentukan buah.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'disease_id' => Str::uuid(),
                'name' => 'Healthy Citrus',
                'description' => 'Tanaman citrus yang bebas dari penyakit.',
                'treatment' => 'Perawatan pencegahan dengan fungisida dan insektisida secara teratur.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
