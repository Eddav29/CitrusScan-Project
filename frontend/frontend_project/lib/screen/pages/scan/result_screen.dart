import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Pastikan Anda mengimpor go_router
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ResultScreen extends StatefulWidget {
  final String imagePath;

  // Constructor menerima path gambar
  const ResultScreen({super.key, required this.imagePath});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isLoading = true; // Set loading ke true saat halaman dimuat
  String _loadingText = 'Identifikasi...'; // Teks pertama yang ditampilkan
  bool _isAnalysisStarted = false; // Menandakan apakah analisis dimulai

  @override
  void initState() {
    super.initState();

    // Mulai proses deteksi secara otomatis setelah halaman dimuat
    _startDetectionProcess();
  }

  void _startDetectionProcess() {
    // Simulasikan proses identifikasi dan analisis hasil dengan delay
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _loadingText =
            'Analisis Hasil...'; // Setelah identifikasi selesai, tampilkan teks analisis
      });

      // Simulasikan waktu analisis hasil
      Future.delayed(Duration(seconds: 3), () {
        // Setelah analisis selesai, arahkan ke halaman hasil deteksi
      context.go('/resultDetection', extra: widget.imagePath);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Background putih untuk halaman
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan gambar yang dipilih
              if (widget.imagePath.isNotEmpty)
                Image.file(
                  File(widget.imagePath),
                  height: screenHeight * 0.45,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
            ],
          ),
          // Animasi Loading
          Positioned(
            top: screenHeight * 0.55, // Memindahkan animasi lebih ke bawah
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.twistingDots(
                    leftDotColor: const Color(0xFF215C3C), // Warna hijau tua
                    rightDotColor: const Color(0xFFFFD700), // Warna kuning
                    size: 100, // Ukuran loading
                  ),
                  SizedBox(height: 16),
                  // Teks loading, berubah sesuai status
                  Text(
                    _loadingText,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF215C3C), // Warna teks
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
