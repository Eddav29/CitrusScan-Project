import 'package:flutter/material.dart';
import '../scan/scan_result_screen.dart';

class ScanHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Scan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF215C3C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu pertama
          _buildScanHistoryCard(
            context, // Menambahkan context sebagai parameter
            imagePath: 'assets/images/jeruknipis.jpeg',
            namaJeruk: 'Jeruk Nipis',
            tanggalScan: '10 Okt 2024',
            kondisi: 'Kondisi Baik',
            keterangan:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          ),
          SizedBox(height: 16),
          // Kartu kedua
          _buildScanHistoryCard(
            context, // Menambahkan context sebagai parameter
            imagePath: 'assets/images/jeruk1.png',
            namaJeruk: 'Jeruk Manis',
            tanggalScan: '2 Okt 2024',
            kondisi: 'Kondisi Baik',
            keterangan:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          ),
          SizedBox(height: 16),
          // Tambahkan lebih banyak kartu sesuai kebutuhan
        ],
      ),
    );
  }

  // Widget untuk membangun kartu riwayat scan
  Widget _buildScanHistoryCard(
    BuildContext context, {
    required String imagePath,
    required String namaJeruk,
    required String tanggalScan,
    required String kondisi,
    required String keterangan,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman hasil scan saat kartu diklik
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ScanResultScreen(imagePath: '',)), // Ganti dengan halaman hasil scan yang sesuai
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF215C3C)
              .withOpacity(0.1), // Warna hijau dengan transparansi
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // Gambar scan jeruk
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
            // Kolom teks dengan nama jeruk, tanggal scan, kondisi, dan keterangan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaJeruk,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    tanggalScan,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    kondisi, // Kondisi jeruk
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    keterangan, // Keterangan tambahan
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54, // Warna hitam dengan transparansi
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
