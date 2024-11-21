<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class DiseaseTreatmentSeeder extends Seeder
{
    public function run()
    {
        // Ambil data dari tabel diseases
        $diseases = DB::table('diseases')->get();

        foreach ($diseases as $disease) {
            $steps = [];

            switch ($disease->name) {
                case 'Citrus Black Spot':
                    $steps = [
                        'Identifikasi buah dengan bercak hitam.',
                        'Pangkas dan buang buah yang terinfeksi.',
                        'Aplikasikan fungisida berbasis tembaga.',
                        'Lakukan sanitasi kebun secara teratur.',
                        'Monitoring setiap 2 minggu selama musim hujan.',
                    ];
                    break;

                case 'Citrus Greening (HLB)':
                    $steps = [
                        'Identifikasi gejala daun menguning tidak simetris.',
                        'Lakukan kontrol terhadap kutu loncat menggunakan insektisida.',
                        'Cabut tanaman yang menunjukkan gejala parah.',
                        'Tanam varietas citrus tahan HLB jika memungkinkan.',
                        'Monitoring kutu loncat menggunakan perangkap kuning lengket.',
                    ];
                    break;

                case 'Citrus Canker':
                    $steps = [
                        'Identifikasi lesi atau luka pada daun dan buah.',
                        'Pangkas bagian tanaman yang terinfeksi.',
                        'Semprotkan bakterisida berbasis tembaga setiap 14 hari.',
                        'Hindari penyiraman overhead untuk mencegah penyebaran bakteri.',
                        'Lakukan sanitasi alat pertanian setelah digunakan.',
                    ];
                    break;

                case 'Citrus Melanose':
                    $steps = [
                        'Identifikasi bintik coklat kecil pada daun atau buah.',
                        'Pangkas cabang mati untuk mencegah penyebaran jamur.',
                        'Aplikasikan fungisida sebelum pembentukan buah.',
                        'Pastikan drainase kebun baik untuk mengurangi kelembapan.',
                        'Monitoring setiap bulan selama musim tanam.',
                    ];
                    break;

                case 'Healthy Citrus':
                    $steps = [
                        'Lakukan pemupukan rutin dengan pupuk NPK.',
                        'Gunakan mulsa untuk menjaga kelembapan tanah.',
                        'Aplikasikan fungisida preventif pada musim hujan.',
                        'Pantau tanda-tanda awal penyakit secara berkala.',
                        'Lakukan rotasi tanaman jika memungkinkan.',
                    ];
                    break;

                default:
                    $steps = [];
            }

            foreach ($steps as $index => $step) {
                DB::table('disease_treatments')->insert([
                    'disease_treatments_id' => Str::uuid(),
                    'disease_id' => $disease->disease_id,
                    'step' => $index + 1, // Langkah dimulai dari 1
                    'action' => $step, // Deskripsi langkah
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }
}
