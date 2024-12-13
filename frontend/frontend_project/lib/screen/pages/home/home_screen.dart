import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/widgets/navigation_bar.dart';
import 'tips_widget.dart';
import '../scan/recent_scan_widget.dart';
import 'data_jeruk_widget.dart';
import '../../common/widgets/app_bar.dart';
import '../history/scan_history_screen.dart';
import '../search/search_disease.dart';
import '../scan/scan_result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color appBarColor = Colors.transparent;

  // Data dummy untuk riwayat jeruk
  final List<Map<String, String>> jerukData = [
    {
      "namaJeruk": "Jeruk Manis",
      "tanggalScan": "2 Okt 2024",
      "imagePath": 'assets/images/jeruk1.png',
    },
    {
      "namaJeruk": "Jeruk Nipis",
      "tanggalScan": "10 Okt 2024",
      "imagePath": 'assets/images/jeruknipis.jpeg',
    },
    {
      "namaJeruk": "Jeruk Bali",
      "tanggalScan": "12 Okt 2024",
      "imagePath": 'assets/images/jeruk1.png',
    },
    {
      "namaJeruk": "Jeruk Keprok",
      "tanggalScan": "15 Okt 2024",
      "imagePath": 'assets/images/jeruknipis.jpeg',
    },
  ];

  List<Widget> buildJerukRows() {
    List<Widget> rows = [];
    for (int i = 0; i < jerukData.length; i += 2) {
      DataJerukWidget leftCard = DataJerukWidget(
        namaJeruk: jerukData[i]["namaJeruk"]!,
        tanggalScan: jerukData[i]["tanggalScan"]!,
        imagePath: jerukData[i]["imagePath"]!,
      );

      DataJerukWidget rightCard = (i + 1 < jerukData.length)
          ? DataJerukWidget(
              namaJeruk: jerukData[i + 1]["namaJeruk"]!,
              tanggalScan: jerukData[i + 1]["tanggalScan"]!,
              imagePath: jerukData[i + 1]["imagePath"]!,
            )
          : DataJerukWidget(
              namaJeruk: "",
              tanggalScan: "",
              imagePath: "",
            );

      rows.add(JerukRowWidget(leftCard: leftCard, rightCard: rightCard));
      rows.add(SizedBox(height: 10));
    }
    return rows;
  }

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
                        "Riwayat Deteksi Terakhir",
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
                  // Menampilkan riwayat scan dengan _buildScanHistoryCard
                  _buildScanHistoryCard(
                    context,
                    imagePath: 'assets/images/jeruk1.png',
                    deteksi: 'Jeruk Manis',
                    tanggal: '2 Okt 2024',
                    saran: 'Cek lebih lanjut untuk kualitas jeruk.',
                    isSelected: false,
                  ),
                  SizedBox(height: 20),
                  // Data jeruk saya
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Data Jeruk Saya",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                            print("Lihat Selengkapnya Data Jeruk tapped");
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Menampilkan semua data jeruk
                  Column(
                    children: buildJerukRows(),
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
}

// Define the reusable scan history card widget
Widget _buildScanHistoryCard(
  BuildContext context, {
  required String imagePath,
  required String deteksi,
  required String tanggal,
  required String saran,
  required bool isSelected,
}) {
  return GestureDetector(
    onTap: () {
      // Navigate to the ScanResultScreen and pass the imagePath
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScanResultScreen(imagePath: imagePath),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF215C3C).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deteksi,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      saran,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    SizedBox(height: 4),
                    Text(
                      tanggal,
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
