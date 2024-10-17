import 'package:flutter/material.dart';

class ScanResultScreen extends StatefulWidget {
  @override
  _ScanResultScreenState createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends State<ScanResultScreen> {
  bool isLoved = false; // Boolean to track whether the love icon is clicked
  bool isBookmarked = false; // Boolean to track whether the bookmark icon is clicked

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar di bagian atas
              Image.asset(
                'assets/images/daunsakit.jpg', // Ganti dengan gambar yang sesuai
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 100), // Memberi jarak untuk naikkan card
            ],
          ),
          // Membungkus konten dengan SingleChildScrollView
          Positioned(
            top: 230, // Naikkan sedikit menutupi gambar
            left: 0,
            right: 0,
            bottom: 0, // Mengisi sampai ke navbar
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), // Lengkungan besar di atas
                    topRight: Radius.circular(40), // Lengkungan besar di atas
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Deskripsi tanaman
                    Text(
                      'Jeruk Manis',
                      style: TextStyle(
                        fontFamily: 'Gilroy', // Menggunakan font Gilroy
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Sakit (Daun Kuning)',
                      style: TextStyle(
                        fontFamily: 'Gilroy', // Menggunakan font Gilroy
                        fontSize: 20,
                        color: Colors.red, // Menggunakan warna merah untuk kondisi sakit
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed lacinia justo, ut blandit felis. Sed ac dolor quis justo commodo dignissim id ac justo.',
                      style: TextStyle(
                        fontFamily: 'Gilroy', // Menggunakan font Gilroy
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Saran Perawatan:',
                      style: TextStyle(
                        fontFamily: 'Gilroy', // Menggunakan font Gilroy
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. Periksa kelembaban tanah dan pastikan tidak terlalu kering. \n2. Kurangi penyiraman jika terlalu banyak. \n3. Tempatkan tanaman di tempat yang mendapatkan cahaya cukup, tetapi tidak terkena sinar matahari langsung. \n4. Hapus daun yang menguning untuk mencegah penyebaran penyakit.',
                      style: TextStyle(
                        fontFamily: 'Gilroy', // Menggunakan font Gilroy
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Ikon kembali di kiri atas dengan latar belakang putih dan ikon hijau
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: EdgeInsets.all(8.0), // Padding added to increase background size
              decoration: BoxDecoration(
                color: Colors.white, // Latar belakang putih
                borderRadius: BorderRadius.circular(8), // Mengatur border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF215C3C)), // Ikon hijau
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          // Ikon love di kanan atas dengan latar belakang putih dan ikon hijau
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.all(8.0), // Padding added to match the back icon's background size
              decoration: BoxDecoration(
                color: Colors.white, // Latar belakang putih
                borderRadius: BorderRadius.circular(8), // Mengatur border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  isLoved ? Icons.favorite : Icons.favorite_border, // Ikon berubah sesuai state
                  color: isLoved ? Colors.red : Color(0xFF215C3C), // Warna berubah sesuai state
                ),
                onPressed: () {
                  setState(() {
                    isLoved = !isLoved; // Toggle the state
                  });
                },
              ),
            ),
          ),
        ],
      ),
      // Navbar di bagian bawah
      bottomNavigationBar: BottomAppBar(
        color: Colors.white, // Warna navbar menjadi putih
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Mengatur tombol agar memenuhi ruang
            children: [
              // Tombol Deteksi Lagi di tengah dan lebih lebar
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Aksi untuk tombol Deteksi Lagi
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF215C3C), // Warna hijau yang baru
                    padding: EdgeInsets.symmetric(vertical: 16), // Lebar tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Border radius sedikit lebih kotak
                    ),
                  ),
                  icon: Icon(Icons.center_focus_strong, color: Colors.white), // Ikon scan
                  label: Text(
                    'Deteksi Lagi',
                    style: TextStyle(fontFamily: 'Gilroy', fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 20), // Jarak antara tombol dan bookmark
              // Ikon Bookmark
              IconButton(
                onPressed: () {
                  setState(() {
                    isBookmarked = !isBookmarked; // Toggle the bookmark state
                  });
                },
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border, // Ikon berubah sesuai state
                  color: isBookmarked ? Color(0xFF215C3C) : Colors.grey, // Warna berubah sesuai state
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
