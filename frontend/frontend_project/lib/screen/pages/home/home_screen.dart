import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/widgets/navigation_bar.dart';
import 'tips_widget.dart';
import '../scan/recent_scan_widget.dart';
import '../../common/widgets/app_bar.dart';
import '../history/scan_history_screen.dart';
import '../search/search_disease.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color appBarColor = Colors.transparent;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appBarColor,
            expandedHeight: 70.0,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              background: CustomAppBar(backgroundColor: appBarColor),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bar pencarian
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman pencarian penyakit
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchDiseaseScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Colors.grey),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Mulai pencarian Anda',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Teks selamat datang
                  Text(
                    "Selamat datang di CitrusScan, solusi untuk mendeteksi dan menganalisis jeruk dengan cepat dan mudah.",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                  SizedBox(height: 20),
                  // Widget tips
                  TipsWidget(),
                  SizedBox(height: 20),
                  // Riwayat scan terakhir
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Riwayat Scan Terakhir",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF215C3C),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward, color: Colors.white),
                          onPressed: () {
                            // Pindah ke halaman riwayat scan lengkap
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScanHistoryScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Menampilkan riwayat scan
                  RecentScanWidget(),
                  SizedBox(height: 20),
                   // Bagian kategori penyakit
                  Text(
                    "Kategori Penyakit",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                  SizedBox(height: 10),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2, // 2 kolom per baris
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 4, // Proporsi untuk mendekati desain
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _buildDiseaseCard(
                          'Black Spot', 'assets/images/black-spot.jpg'),
                      _buildDiseaseCard(
                          'Melanose', 'assets/images/melanose.jpeg'),
                      _buildDiseaseCard('Canker', 'assets/images/canker.jpg'),
                      _buildDiseaseCard(
                          'Greening', 'assets/images/greening.jpeg'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  // Widget untuk setiap kartu penyakit
  Widget _buildDiseaseCard(String name, String imagePath) {
  return GestureDetector(
    onTap: () {
       // Menambahkan logika if-else untuk menangani masing-masing penyakit
      if (name == 'Canker') {
        
      } else if (name == 'Greening') {
       
      } else if (name == 'Black Spot') {
      } else if (name == 'Melanose') {
      }
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Stack(
        children: [
          // Gambar latar belakang
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Layer dengan efek gradasi hitam
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF215C3C).withOpacity(0.5), // Bagian atas lebih terang
                    Color(0xFF215C3C).withOpacity(0.7), // Bagian bawah lebih gelap
                  ],
                ),
              ),
            ),
          ),
          // Teks di atas gambar
          Positioned(
            bottom: 8, // Jarak dari bagian bawah
            left: 8,   // Jarak dari bagian kiri
            right: 8,  // Jarak dari bagian kanan
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Warna teks putih
                shadows: [
                  Shadow(
                    offset: Offset(0, 1), // Bayangan vertikal
                    blurRadius: 2,
                    color: Color(0xFF215C3C).withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

}