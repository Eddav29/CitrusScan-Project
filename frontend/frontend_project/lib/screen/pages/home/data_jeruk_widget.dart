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
                    fontFamily: 'Gilroy', // Menggunakan font Gilroy
                  ),
                ),
                SizedBox(height: 4), // Memberikan jarak vertikal antara nama dan tanggal
                Text(
                  "Tanggal Scan: $tanggalScan", // Menampilkan label tanggal scan
                  style: TextStyle(
                    color: Colors.grey, // Warna teks abu-abu
                    fontSize: 14, // Ukuran font 14
                    fontFamily: 'Gilroy', // Menggunakan font Gilroy
                  ),
                ),
                SizedBox(height: 4), // Mengurangi jarak vertikal sebelum lorem ipsum
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam at dolor vitae orci tempor accumsan.", // Teks lorem ipsum
                  style: TextStyle(
                    fontSize: 12, // Ukuran font 12
                    color: Colors.black54, // Warna teks hitam dengan transparansi
                    fontFamily: 'Gilroy', // Menggunakan font Gilroy
                  ),
                ),
                SizedBox(height: 4), // Jarak vertikal setelah lorem ipsum yang lebih sedikit
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk menampilkan dua DataJerukWidget dalam satu baris
class JerukRowWidget extends StatelessWidget {
  final DataJerukWidget leftCard;
  final DataJerukWidget rightCard;

  JerukRowWidget({required this.leftCard, required this.rightCard});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: leftCard),
        SizedBox(width: 10),
        Expanded(child: rightCard),
      ],
    );
  }
}

// Widget utama yang mencakup semua DataJerukWidget
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        JerukRowWidget(
          leftCard: DataJerukWidget(
            namaJeruk: "Jeruk Manis",
            tanggalScan: "2 Okt 2024",
            imagePath: 'assets/images/daunjeruk2.jpg',
          ),
          rightCard: DataJerukWidget(
            namaJeruk: "Jeruk Nipis",
            tanggalScan: "10 Okt 2024",
            imagePath: 'assets/images/jeruknipis1.jpg',
          ),
        ),
        SizedBox(height: 10),
        JerukRowWidget(
          leftCard: DataJerukWidget(
            namaJeruk: "Jeruk Bali",
            tanggalScan: "12 Okt 2024",
            imagePath: 'assets/images/jerukbali.jpeg',
          ),
          rightCard: DataJerukWidget(
            namaJeruk: "Jeruk Keprok",
            tanggalScan: "15 Okt 2024",
            imagePath: 'assets/images/jerukkeprok.jpg',
          ),
        ),
        SizedBox(height: 10),
        JerukRowWidget(
          leftCard: DataJerukWidget(
            namaJeruk: "Jeruk Nipis Kecil",
            tanggalScan: "18 Okt 2024",
            imagePath: 'assets/images/daunjeruk2.jpg',
          ),
          rightCard: DataJerukWidget(
            namaJeruk: "Jeruk Sunkist",
            tanggalScan: "20 Okt 2024",
            imagePath: 'assets/images/daunjeruk2.jpg',
          ),
        ),
      ],
    );
  }
}
