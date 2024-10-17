import 'package:citrus_scan/screen/login_screen.dart';
import 'package:citrus_scan/screen/splash_screen.dart';
import 'package:citrus_scan/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'screen/home_screen.dart';


void main() {
  runApp(CitrusScanApp());
}

class CitrusScanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan tulisan "debug"
      title: 'CitrusScan',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xFF215C3C)), // Warna utama hijau
      ),
      initialRoute: '/', // Rute awal aplikasi
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(), 
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        // Tambahkan rute lainnya sesuai dengan fitur yang tersedia
      },
    );
  }

  // Fungsi untuk membuat MaterialColor dari Color
  MaterialColor createMaterialColor(Color color) {
    List<double> strengths = <double>[.05]; // Daftar tingkat kekuatan warna
    Map<int, Color> swatch = {}; // Peta untuk menyimpan variasi warna
    final int r = color.red, g = color.green, b = color.blue; // Ambil komponen RGB dari warna

    // Menambahkan kekuatan warna yang berbeda
    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    // Menghitung setiap variasi warna berdasarkan kekuatan
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    // Mengembalikan MaterialColor yang sudah dibuat
    return MaterialColor(color.value, swatch);
  }
}
