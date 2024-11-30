import 'dart:io'; // Untuk menampilkan file gambar
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScanResultScreen extends StatefulWidget {
  final String imagePath; // Menerima path gambar yang di-scan

  ScanResultScreen({required this.imagePath});

  @override
  _ScanResultScreenState createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends State<ScanResultScreen> {
  bool isBookmarked = false; // Boolean untuk menandai bookmark

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.file(
                File(widget.imagePath), // Menggunakan path gambar yang diterima
                height: screenHeight * 0.45,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 0),
            ],
          ),
          Positioned(
            top: screenHeight * 0.4,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(234, 245, 239, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[200],
                            child: Icon(Icons.bug_report,
                                size: 30, color: Colors.white),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Black Spot',
                                  style: TextStyle(
                                    fontFamily: 'Black Spot',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Penyakit bercak hitam yang menyerang daun jeruk.',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' Hasil ini didiagnosis secara otomatis. Harap konfirmasikan bahwa '
                                'masalah tanaman mencerminkan gejala yang dijelaskan sebelum mengambil tindakan.',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    buildInfoBox(
                      title: 'Ringkasan',
                      content:
                          'Black spot atau bercak hitam pada daun jeruk adalah penyakit yang disebabkan oleh jamur Diplocarpon rosae. Penyakit ini umum menyerang berbagai jenis tanaman jeruk dan dapat berkembang pesat dalam kondisi cuaca lembap dan hangat.\n\n'
                          'Black spot menyebabkan munculnya bercak-bercak hitam pada daun yang dapat mengganggu fotosintesis dan menurunkan kualitas tanaman. Penyakit ini sering kali menyerang bagian bawah daun, dan meskipun biasanya tidak mematikan tanaman, infestasi yang parah dapat mengurangi hasil buah.\n\n'
                          'Black spot berkembang lebih cepat pada musim hujan atau ketika kelembapan udara tinggi. Serangan jamur ini lebih rentan terjadi pada tanaman yang tidak sehat atau yang memiliki masalah dalam sirkulasi udara, penyiraman, atau pemupukan. Tanaman jeruk yang tumbuh terlalu rapat dan kurangnya pemangkasan yang baik juga meningkatkan risiko terjadinya penyakit ini.',
                      icon: Icons.info,
                    ),
                    SizedBox(height: 16),
                    buildInfoBox(
                      title: 'Gejala',
                      content:
                          'Gejala utama black spot pada tanaman jeruk adalah munculnya bercak-bercak hitam pada permukaan daun. Bercak ini biasanya dimulai dengan titik-titik kecil berwarna hitam yang berkembang menjadi area yang lebih besar dengan batas yang jelas.\n\n'
                          'Daun yang terinfeksi akan menguning dan akhirnya gugur jika serangan semakin parah. Pada awal infeksi, bercak bisa tampak kecil dan berbentuk bundar dengan titik tengah berwarna hitam. Seiring waktu, bercak ini akan berkembang dan menyebabkan kerusakan pada daun, yang mengurangi kemampuannya untuk fotosintesis.\n\n'
                          'Tanaman yang terinfeksi juga mungkin menunjukkan penurunan pertumbuhan dan hasil buah yang lebih rendah. Pada kasus yang sangat parah, seluruh daun dapat jatuh, mengakibatkan penurunan kesehatan pohon jeruk secara keseluruhan.',
                      icon: Icons.warning,
                    ),
                    SizedBox(height: 16),
                    buildInfoBox(
                      title: 'Solusi',
                      content:
                          'Black spot pada daun jeruk dapat dikendalikan dengan beberapa metode, baik secara fisik, biologis, maupun kimiawi:\n\n'
                          'Untuk kasus yang tidak terlalu parah:\n'
                          '🟢 Buang daun-daun yang terkena black spot untuk mencegah penyebaran lebih lanjut.\n'
                          '🟢 Pastikan pohon jeruk tidak terlalu rapat untuk memperbaiki sirkulasi udara, yang membantu mengurangi kelembapan dan menghambat perkembangan jamur.\n'
                          '🟢 Menghindari penyiraman malam hari yang dapat meningkatkan kelembapan di sekitar tanaman.\n'
                          '🟢 Semprotkan campuran minyak neem atau minyak hortikultura untuk membatasi penyebaran jamur.\n\n'
                          'Untuk kasus yang parah:\n'
                          '🟢 Terapkan fungisida yang mengandung bahan aktif seperti chlorothalonil, myclobutanil, atau copper fungicide sesuai petunjuk pada label produk.\n'
                          '🟢 Potong cabang dan daun yang terinfeksi secara menyeluruh dan pastikan untuk membuangnya jauh dari kebun untuk mencegah penyebaran lebih lanjut.\n'
                          '🟢 Gunakan mulsa untuk menjaga kelembapan tanah tetap seimbang tanpa meningkatkan kelembapan di udara sekitar tanaman.',
                      icon: Icons.check_circle,
                    ),
                    SizedBox(height: 16),
                    buildInfoBox(
                      title: 'Pencegahan',
                      content:
                          'Langkah-langkah pencegahan untuk menghindari infeksi black spot pada tanaman jeruk meliputi:\n\n'
                          '🟢 Pilih varietas jeruk yang lebih tahan terhadap penyakit black spot untuk mengurangi risiko infeksi.\n'
                          '🟢 Bersihkan dedaunan yang gugur dan kotoran dari sekitar tanaman untuk mengurangi tempat berkembang biak jamur.\n'
                          '🟢 Lakukan pemangkasan secara teratur untuk memastikan sirkulasi udara yang baik dan menghindari kelembapan berlebih di sekitar tanaman.\n'
                          '🟢 Pastikan tanaman tidak terkena air yang berlebihan, terutama pada malam hari. Penyiraman yang terlalu banyak dapat menciptakan kondisi yang ideal bagi jamur.\n'
                          '🟢 Terapkan fungisida preventif secara teratur, terutama saat musim hujan atau ketika kelembapan udara tinggi.\n'
                          '🟢 Tanam tanaman jeruk dengan jarak yang cukup agar memungkinkan pertumbuhan yang optimal dan menghindari tanaman yang terlalu rapat yang meningkatkan risiko infeksi.',
                      icon: Icons.shield,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF215C3C)),
                onPressed: () {
                  GoRouter.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF215C3C),
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(0, 56),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.center_focus_strong,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Deteksi Lagi',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoBox(
      {required String title,
      required String content,
      required IconData icon}) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 16,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
