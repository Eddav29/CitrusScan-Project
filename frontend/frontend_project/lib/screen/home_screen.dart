import 'package:flutter/material.dart';
import '../widgets/navigation_bar.dart';
import 'tips_widget.dart';
import 'recent_scan_widget.dart'; // Pastikan sudah mengimpor recent_scan_widget
import 'data_jeruk_widget.dart';
import '../widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color appBarColor = Colors.transparent; // Warna AppBar

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
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Mulai pencarian Anda',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.filter_list, color: Color(0xFF215C3C)),
                        onPressed: () {
                          print("Filter tapped");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Teks selamat datang
                  Text(
                    "Selamat datang di CitrusScan, solusi untuk mendeteksi dan menganalisis jeruk dengan cepat dan mudah.",
                    style: TextStyle(fontSize: 16),
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
                        ),
                      ),
                      // Ikon untuk melihat selengkapnya
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF215C3C), // Warna hijau
                          shape: BoxShape.circle, // Bentuk bulat
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward, color: Colors.white),
                          onPressed: () {
                            print("Lihat Selengkapnya tapped");
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Menampilkan riwayat scan
                  RecentScanWidget(),
                  SizedBox(height: 20),
                  // Data jeruk saya
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Data Jeruk Saya",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      // Ikon untuk melihat selengkapnya
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF215C3C), // Warna hijau
                          shape: BoxShape.circle, // Bentuk bulat
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
                  // Menampilkan data jeruk
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DataJerukWidget(
                        namaJeruk: "Jeruk Manis",
                        tanggalScan: "2 Okt 2024", // Tanggal scan
                        imagePath: 'assets/images/jeruk1.png',
                      ),
                      SizedBox(width: 10),
                      DataJerukWidget(
                        namaJeruk: "Jeruk Nipis",
                        tanggalScan: "10 Okt 2024", // Tanggal scan
                        imagePath: 'assets/images/jeruknipis.jpeg',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(), // Navigasi bawah
    );
  }
}
