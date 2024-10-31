import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Pastikan Anda mengimpor go_router
import '../../common/widgets/loading_screen.dart';

class ResultScreen extends StatelessWidget {
  final String imagePath;

  // Constructor menerima path gambar
  ResultScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF215C3C)), // Ganti warna
          onPressed: () {
            GoRouter.of(context).go('/home'); // Navigasi kembali ke halaman utama
          },
        ),
        title: Text('Hasil Scan'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Menampilkan gambar yang dipilih
                if (imagePath.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Image.file(
                      File(imagePath),
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                // Tombol Deteksi Penyakit
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoadingScreen()),
                    );

                    Future.delayed(Duration(seconds: 3), () {
                      context.go('/resultDetection', extra: imagePath);
                    });

                    // Tambahkan logika deteksi penyakit di sini
                    print('Deteksi Penyakit');
                  },
                  child: Text('Deteksi Penyakit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
