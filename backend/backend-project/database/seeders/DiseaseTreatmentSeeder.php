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
                case 'Black Spot':
                    $steps = [
                        'description' => 'Black spot atau bercak hitam pada daun jeruk adalah penyakit yang disebabkan oleh jamur Diplocarpon rosae. Penyakit ini umum menyerang berbagai jenis tanaman jeruk dan dapat berkembang pesat dalam kondisi cuaca lembap dan hangat. Black spot menyebabkan munculnya bercak-bercak hitam pada daun yang dapat mengganggu fotosintesis dan menurunkan kualitas tanaman. Penyakit ini sering kali menyerang bagian bawah daun, dan meskipun biasanya tidak mematikan tanaman, infestasi yang parah dapat mengurangi hasil buah. Black spot berkembang lebih cepat pada musim hujan atau ketika kelembapan udara tinggi. Serangan jamur ini lebih rentan terjadi pada tanaman yang tidak sehat atau yang memiliki masalah dalam sirkulasi udara, penyiraman, atau pemupukan. Tanaman jeruk yang tumbuh terlalu rapat dan kurangnya pemangkasan yang baik juga meningkatkan risiko terjadinya penyakit ini.',
                        'symptoms' => 'Gejala utama black spot pada tanaman jeruk adalah munculnya bercak-bercak hitam pada permukaan daun. Bercak ini biasanya dimulai dengan titik-titik kecil berwarna hitam yang berkembang menjadi area yang lebih besar dengan batas yang jelas. Daun yang terinfeksi akan menguning dan akhirnya gugur jika serangan semakin parah. Pada awal infeksi, bercak bisa tampak kecil dan berbentuk bundar dengan titik tengah berwarna hitam. Seiring waktu, bercak ini akan berkembang dan menyebabkan kerusakan pada daun, yang mengurangi kemampuannya untuk fotosintesis. Tanaman yang terinfeksi juga mungkin menunjukkan penurunan pertumbuhan dan hasil buah yang lebih rendah. Pada kasus yang sangat parah, seluruh daun dapat jatuh, mengakibatkan penurunan kesehatan pohon jeruk secara keseluruhan.',
                        'solutions' => 'Black spot pada daun jeruk dapat dikendalikan dengan beberapa metode, baik secara fisik, biologis, maupun kimiawi:
                                        
Untuk kasus yang tidak terlalu parah:
• Buang daun-daun yang terkena black spot untuk mencegah penyebaran lebih lanjut.
• Pastikan pohon jeruk tidak terlalu rapat untuk memperbaiki sirkulasi udara, yang membantu mengurangi kelembapan dan menghambat perkembangan jamur.
• Menghindari penyiraman malam hari yang dapat meningkatkan kelembapan di sekitar tanaman.
• Semprotkan campuran minyak neem atau minyak hortikultura untuk membatasi penyebaran jamur.

Untuk kasus yang parah:
• Terapkan fungisida yang mengandung bahan aktif seperti chlorothalonil, myclobutanil, atau copper fungicide sesuai petunjuk pada label produk.
• Potong cabang dan daun yang terinfeksi secara menyeluruh dan pastikan untuk membuangnya jauh dari kebun untuk mencegah penyebaran lebih lanjut.
• Gunakan mulsa untuk menjaga kelembapan tanah tetap seimbang tanpa meningkatkan kelembapan di udara sekitar tanaman.
                                        ',
                        'prevention' => 'Langkah-langkah pencegahan untuk menghindari infeksi black spot pada tanaman jeruk meliputi:
• Pilih varietas jeruk yang lebih tahan terhadap penyakit black spot untuk mengurangi risiko infeksi.
• Bersihkan dedaunan yang gugur dan kotoran dari sekitar tanaman untuk mengurangi tempat berkembang biak jamur.
• Lakukan pemangkasan secara teratur untuk memastikan sirkulasi udara yang baik dan menghindari kelembapan berlebih di sekitar tanaman.
• Pastikan tanaman tidak terkena air yang berlebihan, terutama pada malam hari. Penyiraman yang terlalu banyak dapat menciptakan kondisi yang ideal bagi jamur.
• Terapkan fungisida preventif secara teratur, terutama saat musim hujan atau ketika kelembapan udara tinggi.
• Tanam tanaman jeruk dengan jarak yang cukup agar memungkinkan pertumbuhan yang optimal dan menghindari tanaman yang terlalu rapat yang meningkatkan risiko infeksi.',
                    ];
                    break;

                case 'Greening':
                    $steps = [
                        'description' => 'Greening atau Huanglongbing (HLB), adalah penyakit yang disebabkan oleh bakteri Candidatus Liberibacter asiaticus, yang disebarkan oleh vektor serangga seperti kutu daun. Penyakit ini mengganggu proses fotosintesis dan pertumbuhan tanaman jeruk, menyebabkan daun menguning tidak merata, dan buah menjadi kecil serta tidak berkembang dengan baik. Greening dapat menyebabkan penurunan hasil panen yang drastis, dengan buah yang terinfeksi menjadi asam dan tidak bernilai komersial. Penyakit ini sangat berbahaya karena dapat menyebar dengan cepat dan merusak kebun jeruk secara menyeluruh. Greening lebih mudah berkembang pada tanaman yang telah terinfeksi oleh kutu daun vektor, serta pada tanaman yang tidak sehat atau sedang dalam kondisi stres. Tanaman yang terinfeksi akan menunjukkan penurunan pertumbuhan dan hasil yang signifikan.',
                        'symptoms' => 'Gejala utama penyakit greening pada tanaman jeruk adalah menguningnya daun secara tidak merata, dengan pola yang tidak simetris, yang sering kali dimulai dari tepi daun. Daun yang terinfeksi akan menunjukkan gejala chlorosis (penguningan) yang khas di satu sisi, sementara sisi lainnya tetap hijau. Buah yang terinfeksi biasanya lebih kecil, asimetris, dan berwarna hijau meskipun sudah mendekati matang. Selain itu, buah yang terinfeksi sering kali berasa asam atau tidak enak, dengan tekstur yang keras dan tidak berkembang dengan baik. Tanaman yang terinfeksi juga menunjukkan pertumbuhan yang lambat, kerdil, dan tidak produktif, dengan hasil buah yang sangat berkurang, atau bahkan mati pada infeksi yang parah. Penurunan kualitas dan kuantitas buah yang terpengaruh sangat mengurangi nilai jual hasil panen jeruk.',
                        'solutions' => 'Penyakit greening pada jeruk (HLB) sangat sulit untuk diatasi, tetapi ada beberapa langkah yang dapat membantu mengontrol dan memperlambat penyebarannya:

Untuk kasus yang tidak terlalu parah:
• Kendalikan vektor penyakit, yaitu kutu daun atau serangga penghisap lainnya, dengan insektisida yang tepat atau pengendalian hayati menggunakan predator alami seperti Amblyseius spp.
• Perbaiki kondisi tanaman dengan memastikan pohon mendapatkan pemupukan yang baik dan cukup air untuk menjaga kesehatannya dan meningkatkan daya tahan terhadap infeksi.
• Potong dan buang pohon yang terinfeksi berat, serta cabang-cabang yang sudah tidak produktif untuk mencegah penyebaran penyakit.

Untuk kasus yang parah:
• Gali dan hancurkan pohon yang terinfeksi parah untuk mencegah penyebaran lebih lanjut.
• Gunakan insektisida sistemik yang dapat diterima oleh tanaman jeruk untuk mengurangi populasi kutu daun vektor penyakit.
• Tanam varietas jeruk yang lebih tahan terhadap penyakit greening, jika tersedia, untuk mengurangi risiko infeksi pada kebun jeruk.
• Lakukan pengawasan rutin terhadap tanaman untuk deteksi dini dan segera ambil tindakan jika ditemukan gejala infeksi baru.',
                        'prevention' => 'Langkah-langkah pencegahan untuk menghindari infeksi greening (HLB) pada tanaman jeruk meliputi:
• Gunakan bibit jeruk yang bebas dari penyakit greening dan pastikan tanaman berasal dari sumber yang terpercaya.
• Kontrol populasi vektor penyakit seperti kutu daun dengan menggunakan insektisida yang sesuai atau pengendalian hayati.
• Lakukan pemangkasan cabang yang terinfeksi dan buang bagian tanaman yang menunjukkan gejala greening untuk mencegah penyebaran lebih lanjut.
• Jaga kebersihan kebun dengan membersihkan dedaunan yang gugur dan sisa tanaman yang terinfeksi untuk mengurangi kemungkinan penyebaran bakteri.
• Tanam jeruk dengan jarak yang cukup agar pohon tidak terlalu rapat dan memiliki ruang untuk pertumbuhan optimal serta sirkulasi udara yang baik.
• Lakukan pengawasan rutin terhadap tanaman untuk mendeteksi gejala infeksi lebih awal, dan segera lakukan tindakan jika ditemukan gejala greening.',
                    ];
                    break;

                case 'Cancer':
                    $steps = [
                        'description' => 'cancer pada tanaman jeruk disebabkan oleh infeksi bakteri atau jamur, seperti Phytophthora citrophthora dan Xanthomonas citri. Penyakit ini dapat menyerang daun, batang, dan ranting jeruk, menyebabkan luka dan bercak-bercak pada permukaan tanaman. cancer mengganggu pertumbuhan tanaman jeruk, menyebabkan penurunan kualitas dan kuantitas hasil panen. Infeksi yang parah dapat merusak batang dan ranting, menyebabkan pohon menjadi lemah, dan dalam kasus yang sangat serius, dapat menyebabkan pohon mati. Penyakit ini lebih mudah berkembang pada tanaman yang terluka atau dalam kondisi stres, seperti kekurangan air atau pemupukan yang tidak seimbang. Keberadaan patogen di sekitar kebun dan kurangnya perawatan kebun yang baik juga meningkatkan risiko infeksi cancer.',
                        'symptoms' => 'Gejala utama cancer pada jeruk adalah munculnya luka atau bercak basah yang pada awalnya berwarna kuning atau coklat, yang kemudian berkembang menjadi kerak keras berwarna coklat kehitaman pada batang, cabang, dan ranting. Luka ini biasanya memiliki tepi yang jelas dan bisa menyebar seiring waktu. Pada tanaman yang terinfeksi, daun di sekitar cabang yang terinfeksi akan menguning, menggulung, dan akhirnya gugur. Pada infeksi yang parah, luka pada batang dapat mengganggu aliran air dan nutrisi, yang mengakibatkan penurunan pertumbuhan pohon dan hasil buah yang menurun. Selain itu, pertumbuhan cabang baru akan terhambat, dan tanaman akan menunjukkan gejala stres seperti penurunan ukuran buah dan kualitasnya.',
                        'solutions' => 'Penyakit cancer pada tanaman jeruk dapat dikendalikan dengan beberapa metode yang efektif:
                            
Untuk kasus yang tidak terlalu parah:
• Buang bagian tanaman yang terinfeksi, seperti daun dan ranting yang menunjukkan gejala luka, untuk mengurangi penyebaran infeksi.
• Lakukan pemangkasan secara hati-hati dengan alat yang steril untuk menghindari penyebaran patogen.
• Perbaiki kelembapan dan drainase tanah, agar pohon jeruk tidak terlalu lembap yang bisa memperburuk kondisi infeksi.

Untuk kasus yang parah:
• Gunakan bakterisida atau fungisida yang mengandung bahan aktif seperti copper hydroxide atau streptomycin untuk mengendalikan infeksi.
• Potong semua bagian tanaman yang terinfeksi secara menyeluruh dan buang jauh dari kebun untuk mencegah penyebaran lebih lanjut.
• Lakukan perawatan dengan pengendalian hayati, menggunakan agen pengendali hayati yang dapat mengurangi populasi bakteri atau jamur penyebab cancer.',
                        'prevention' => 'Langkah-langkah pencegahan untuk menghindari infeksi cancer pada tanaman jeruk meliputi:
• Pilih varietas jeruk yang lebih tahan terhadap cancer untuk mengurangi kemungkinan infeksi.
• Jaga kebersihan kebun dengan membersihkan daun-daun yang gugur dan sisa tanaman lainnya yang dapat menjadi tempat berkembang biak patogen.
• Lakukan pemangkasan secara teratur untuk mengurangi kelembapan berlebih dan memastikan sirkulasi udara yang baik di sekitar tanaman.
• Gunakan alat pemangkasan yang steril agar tidak menyebarkan bakteri atau jamur ke bagian tanaman lain.
• Tanam jeruk dengan jarak yang cukup untuk memastikan tanaman mendapatkan sinar matahari yang optimal dan sirkulasi udara yang baik, serta menghindari kelembapan berlebih.
• Terapkan fungisida atau bakterisida secara preventif pada musim yang rentan, terutama saat kelembapan tinggi atau setelah hujan.',
                    ];
                    break;

                case 'Melanose':
                    $steps = [
                        'description' => 'Melanose adalah penyakit pada daun jeruk yang disebabkan oleh jamur Diaporthe citri. Penyakit ini sering menyerang tanaman jeruk dalam kondisi yang lembap dan hangat, serta dapat berkembang pesat pada tanaman yang mengalami stres, seperti kekurangan air atau pemupukan yang tidak tepat. Melanose menyebabkan munculnya bercak-bercak coklat kehitaman pada daun, yang dapat mengurangi kemampuan fotosintesis tanaman dan menurunkan kualitas hasil panen. Meskipun tidak langsung membunuh pohon jeruk, jika tidak dikendalikan, penyakit ini dapat mengurangi produksi buah dan menyebabkan penurunan kesehatan tanaman secara keseluruhan. Jamur penyebab melanose lebih mudah berkembang pada tanaman yang tidak sehat atau memiliki masalah dalam sirkulasi udara, penyiraman, atau pemupukan yang tidak seimbang. Penyakit ini lebih rentan menyerang tanaman yang tumbuh terlalu rapat tanpa pemangkasan yang memadai.',
                        'symptoms' => 'Gejala utama melanose pada jeruk adalah munculnya bercak-bercak hitam pada permukaan daun dan kulit buah. Bercak ini berbentuk bulat atau tidak beraturan dengan tepi yang jelas, dan bisa berkembang menjadi lesi yang lebih besar. Pada daun, gejala ini dapat menyebabkan daun menguning dan rontok jika infeksi semakin parah. Pada buah, bercak-bercak hitam dapat mempengaruhi penampilan dan kualitas hasil panen, menyebabkan cacat pada kulit buah yang mempengaruhi nilai jual.',
                        'solutions' => 'Melanose pada daun jeruk dapat dikendalikan dengan beberapa langkah, baik secara fisik, kimiawi, maupun perawatan tanaman yang tepat:
                                        
Untuk kasus yang tidak terlalu parah:
• Buang daun-daun yang terinfeksi untuk mencegah penyebaran lebih lanjut.
• Lakukan pemangkasan pada bagian tanaman yang terinfeksi, terutama pada daun yang lebih tua dan cabang yang tidak sehat.
• Pastikan pohon jeruk memiliki sirkulasi udara yang baik, dengan memberi jarak tanam yang cukup untuk menghindari kelembapan berlebih yang mendukung pertumbuhan jamur.
• Berikan pemupukan yang seimbang dan perhatikan kebutuhan air agar tanaman tetap sehat dan dapat melawan infeksi.

Untuk kasus yang parah:
• Semprotkan fungisida yang mengandung bahan aktif seperti copper oxychloride atau trifloxystrobin sesuai dengan petunjuk pada label produk.
• Potong dan buang cabang serta daun yang terinfeksi, dan pastikan untuk membuangnya jauh dari kebun untuk mencegah penyebaran lebih lanjut.
• Gunakan mulsa secara hati-hati untuk mengatur kelembapan tanah, namun pastikan tidak meningkatkan kelembapan di udara yang bisa memicu perkembangan jamur.',
                        'prevention' => 'Langkah-langkah pencegahan untuk menghindari infeksi melanose pada tanaman jeruk meliputi:
• Pilih varietas jeruk yang lebih tahan terhadap melanose untuk mengurangi risiko infeksi.
• Bersihkan dedaunan yang gugur dan sisa-sisa tanaman yang terinfeksi untuk mengurangi tempat berkembang biak jamur.
• Lakukan pemangkasan secara teratur untuk memastikan sirkulasi udara yang baik dan menghindari kelembapan berlebih di sekitar tanaman.
• Pastikan tanaman mendapat pemupukan yang seimbang dan cukup air untuk menjaga kesehatannya, mengurangi stres yang dapat membuat tanaman lebih rentan terhadap infeksi.
• Hindari penyiraman berlebihan, terutama pada malam hari, karena kelembapan tinggi yang berlarut-larut dapat mendukung pertumbuhan jamur.
• Terapkan fungisida preventif secara teratur, terutama pada musim hujan atau ketika kelembapan udara tinggi, dengan menggunakan bahan aktif yang sesuai seperti copper oxychloride.',
                    ];
                    break;

                case 'Healthy':
                    $steps = [
                        'description' => 'Tanaman jeruk yang sehat memiliki daun yang hijau segar, batang yang kokoh, dan akar yang kuat. Kondisi ini menunjukkan bahwa tanaman mendapatkan perawatan yang optimal, termasuk penyiraman yang cukup, pencahayaan yang tepat, dan nutrisi yang memadai. Tanaman sehat juga lebih tahan terhadap penyakit dan hama karena sistem kekebalan tubuhnya yang optimal. Pertumbuhan yang baik dan produksi buah yang melimpah adalah tanda utama dari tanaman yang sehat.',
                        'symptoms' => 'Tanaman jeruk yang sehat menunjukkan pertumbuhan yang optimal, dengan daun berwarna hijau cerah, batang kokoh, dan akar yang kuat. Tidak ada tanda-tanda kerusakan atau penyakit pada tanaman, dan pertumbuhannya terus berkembang dengan baik. Tidak ada bercak atau perubahan warna yang tidak normal pada daun, serta buah yang dihasilkan pun bebas dari cacat. Tanaman yang sehat juga lebih tahan terhadap perubahan cuaca dan stres lingkungan.',
                        'solutions' => 'Untuk menjaga tanaman tetap sehat, beberapa tindakan dapat dilakukan:
• Pastikan tanaman mendapatkan air yang cukup, terutama selama musim kemarau.
• Berikan pupuk yang seimbang dan sesuai dengan tahap pertumbuhan tanaman.
• Lakukan pemangkasan secara teratur untuk menghilangkan daun atau cabang yang mati.
• Jagalah kebersihan area sekitar tanaman untuk mencegah penyebaran penyakit.',
                        'prevention' => 'Pencegahan sangat penting agar tanaman tetap sehat dan bebas dari penyakit:
• Jaga kelembaban tanah agar tidak terlalu kering atau terlalu basah.
• Tanam jeruk di lokasi yang mendapatkan sinar matahari cukup.
• Gunakan pupuk secara teratur untuk mendukung pertumbuhan tanaman.',
                    ];
                    break;

                default:
                    $steps = [];
            }

            if (!empty($steps)) {
                DB::table('disease_treatments')->insert([
                    'disease_treatments_id' => Str::uuid(),
                    'disease_id' => $disease->disease_id,
                    'description' => $steps['description'],
                    'symptoms' => $steps['symptoms'],
                    'solutions' => $steps['solutions'],
                    'prevention' => $steps['prevention'],
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }
}
