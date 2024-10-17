import 'package:flutter/material.dart';
import 'package:citrus_scan/screen/camera_screen.dart'; // Import CameraScreen
import 'package:citrus_scan/screen/scan_result_screen.dart'; // Import ScanResultScreen

class CustomNavigationBar extends StatefulWidget {
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _currentIndex = 0; // Melacak indeks yang dipilih saat ini

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Mencegah elemen terpotong di luar batas
      children: [
        BottomNavigationBar(
          currentIndex: _currentIndex, // Menandai item mana yang sedang aktif
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Mengubah indeks yang dipilih saat item ditekan
            });

            // Penanganan navigasi untuk Home dan Profile
            if (index == 0) {
              print('Home ditekan');
              // Navigasi ke halaman Home (Anda dapat menambahkan logika navigasi jika diperlukan)
            } else if (index == 1) {
              print('Profile ditekan');
              // Navigasi ke halaman Scan Result Screen saat profil ditekan
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanResultScreen()), // Navigasi ke ScanResultScreen
              );
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.fixed, // Jenis navigasi bar tetap
          backgroundColor: Colors.white,       // Warna latar belakang bar navigasi
          elevation: 0,                        // Menghilangkan efek bayangan
          selectedItemColor: Color(0xFF215C3C),  // Warna item yang dipilih (hijau)
          unselectedItemColor: Colors.grey,      // Warna item yang tidak dipilih (abu-abu)
        ),
        Positioned(
          top: -30, // Posisi tombol melayang di atas navbar
          left: MediaQuery.of(context).size.width * 0.5 - 28, // Pusatkan tombol di navbar
          child: FloatingActionButton(
            onPressed: () {
              // Navigasi ke CameraScreen ketika tombol Scan ditekan
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraScreen()),
              );
            },
            backgroundColor: Color(0xFF215C3C),  // Warna tombol (hijau)
            child: Icon(Icons.center_focus_strong, size: 30, color: Colors.white), // Ikon untuk tombol scan
            elevation: 2,  // Memberikan sedikit bayangan untuk tombol
          ),
        ),
      ],
    );
  }
}
