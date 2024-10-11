import 'dart:io';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final File image; // gambar yang diambil atau dipilih

  const ResultScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Scan'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.file(image), // menampilkan gambar
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Lakukan proses deteksi penyakit di sini
              // Misalnya panggil fungsi deteksi atau pindah ke halaman lain
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Mendeteksi penyakit...')),
              );
            },
            child: Text('Deteksi Penyakit'),
          ),
        ],
      ),
    );
  }
}
