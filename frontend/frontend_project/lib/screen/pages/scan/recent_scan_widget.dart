import 'package:flutter/material.dart';
import 'scan_result_screen.dart';

class RecentScanWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        // Kartu Riwayat Scan
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              // Arahkan ke halaman ScanResultScreen saat kartu diklik
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ScanResultScreen(
                          imagePath: '',
                        )),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF215C3C)
                    .withOpacity(0.1), // Warna hijau transparan
                borderRadius: BorderRadius.circular(12), // Sudut melengkung
              ),
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(
                  bottom:
                      16), // Menambahkan margin bawah untuk jarak antar item
              child: Row(
                children: [
                  // Gambar hasil scan
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/jeruknipis.jpeg',
                      width:
                          80, // Sesuaikan dengan ukuran gambar di ScanHistoryScreen
                      height:
                          80, // Sesuaikan dengan ukuran gambar di ScanHistoryScreen
                      fit: BoxFit.cover, // Menjaga proporsi gambar
                    ),
                  ),
                  SizedBox(width: 16), // Jarak antara gambar dan teks
                  // Kolom untuk menampilkan teks di sebelah kanan
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jeruk Nipis', // Nama produk
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Warna font hitam
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', // Keterangan tambahan
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors
                                .black54, // Warna hitam dengan transparansi
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '10 Okt 2024', // Tanggal scan
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors
                                .black54, // Warna font hitam dengan transparansi
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
