import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna background putih (atau bisa diganti sesuai kebutuhan)
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200), // Jarak dari atas
            LoadingAnimationWidget.twistingDots(
              leftDotColor: const Color(0xFF215C3C), // Warna hijau tua
              rightDotColor: const Color(0xFFFFD700), // Warna kuning
              size: 100, // Ukuran loading
            ),
            SizedBox(height: 16),
            Text(
              'Menyimpan Foto...',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF215C3C), // Warna teks
              ),
            ),
          ],
        ),
      ),
    );
  }
}
