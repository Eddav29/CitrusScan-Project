import 'package:flutter/material.dart';

class DataJerukWidget extends StatelessWidget {
  final String namaJeruk; // Nama jeruk yang akan ditampilkan
  final String tanggalScan; // Tanggal scan jeruk
  final String imagePath; // Path gambar jeruk

  DataJerukWidget({
    required this.namaJeruk,
    required this.tanggalScan,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45, // Mengatur lebar widget menjadi 45% dari lebar layar
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang container
        borderRadius: BorderRadius.circular(12), // Membuat sudut container melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Bayangan berwarna abu-abu dengan sedikit transparansi
            spreadRadius: 2, // Menyebarkan bayangan
            blurRadius: 5, // Efek blur pada bayangan
            offset: Offset(0, 3), // Offset bayangan dari widget
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur konten di dalam column agar mulai dari kiri
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), // Sudut kiri atas gambar melengkung
              topRight: Radius.circular(12), // Sudut kanan atas gambar melengkung
            ),
            child: Image.asset(
              imagePath, // Menampilkan gambar dari path yang diberikan
              width: double.infinity, // Gambar memenuhi lebar container
              height: 100, // Mengatur tinggi gambar
              fit: BoxFit.cover, // Gambar menyesuaikan dengan ukuran widget tanpa terpotong
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0), // Padding di dalam konten teks
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Teks dimulai dari sisi kiri
              children: [
                Text(
                  namaJeruk, // Menampilkan nama jeruk
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Teks tebal
                    fontSize: 16, // Ukuran font 16
                  ),
                ),
                SizedBox(height: 4), // Memberikan jarak vertikal antara nama dan tanggal
                Text(
                  "Tanggal Scan: $tanggalScan", // Menampilkan label tanggal scan
                  style: TextStyle(
                    color: Colors.grey, // Warna teks abu-abu
                    fontSize: 14, // Ukuran font 14
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
