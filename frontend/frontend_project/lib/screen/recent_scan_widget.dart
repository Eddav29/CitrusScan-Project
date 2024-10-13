import 'package:flutter/material.dart';

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
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF215C3C).withOpacity(0.1), // Warna hijau transparan
              borderRadius: BorderRadius.circular(12), // Sudut melengkung
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                // Gambar hasil scan
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/jeruknipis.jpeg',
                    width: 100, // Lebar gambar
                    height: 100, // Tinggi gambar
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
                      SizedBox(height: 8),
                      Text(
                        'Kondisi Baik', // Kondisi produk
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Warna font hitam
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', // Keterangan tambahan
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
        ),
      ],
    );
  }
}
