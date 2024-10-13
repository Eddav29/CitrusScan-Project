import 'package:flutter/material.dart';

class TipsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF215C3C), // Warna latar belakang sesuai dengan tema
        borderRadius: BorderRadius.circular(20), // Sudut card melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // Warna bayangan
            blurRadius: 10, // Tingkat kabur bayangan
            offset: Offset(0, 4), // Posisi bayangan
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Jarak di dalam container
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Penempatan vertikal pada row
          children: [
            // Ikon Lampu
            Icon(
              Icons.lightbulb_outline, // Ikon lampu
              color: Colors.white, // Warna ikon putih
              size: 24, // Ukuran ikon
            ),
            SizedBox(width: 10), // Jarak antara ikon dan teks

            // Teks Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Penempatan teks di kiri
                children: [
                  Text(
                    "Info Penting", // Judul informasi
                    style: TextStyle(
                      fontSize: 18, // Ukuran font judul
                      fontWeight: FontWeight.bold, // Bold untuk judul
                      color: Colors.white, // Warna teks judul putih
                    ),
                  ),
                  SizedBox(height: 8), // Jarak antara judul dan deskripsi
                  Text(
                    "Jeruk membutuhkan banyak cahaya dan suhu yang stabil untuk berkembang dengan baik.", // Deskripsi info
                    style: TextStyle(
                      fontSize: 14, // Ukuran font deskripsi
                      color: Colors.white70, // Warna teks deskripsi dengan transparansi
                    ),
                  ),
                ],
              ),
            ),

            // Ikon untuk refresh atau reload (belum ada di kode, bisa ditambahkan jika perlu)
          ],
        ),
      ),
    );
  }
}
