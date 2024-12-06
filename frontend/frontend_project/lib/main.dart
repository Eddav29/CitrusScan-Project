import 'package:citrus_scan/provider/provider.dart';
import 'package:citrus_scan/screen/pages/auth/login_screen.dart';
import 'package:citrus_scan/screen/pages/password/enter_new_password.dart';
import 'package:citrus_scan/screen/pages/password/succes.dart';
import 'package:citrus_scan/screen/pages/password/verification_code_screen.dart';
import 'package:citrus_scan/screen/pages/profile/edit_profile.dart';
import 'package:citrus_scan/screen/splash_screen.dart';
import 'package:citrus_scan/screen/pages/auth/register_screen.dart';
import 'package:citrus_scan/screen/pages/scan/result_screen.dart';
import 'package:citrus_scan/screen/pages/scan/scan_result_screen.dart'; // Import ScanResultScreen
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:citrus_scan/screen/pages/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/screen/pages/profile/profile_screen.dart';
import 'package:citrus_scan/screen/pages/profile/change_password.dart';
import 'package:citrus_scan/screen/pages/password/reset_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Test koneksi API
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // Override the sharedPreferencesProvider with the instance
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: CitrusScanApp(),
    ),
  );
}

class CitrusScanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Definisikan GoRouter
    final GoRouter _router = GoRouter(
      initialLocation: '/', // Lokasi awal aplikasi
      routes: [
        GoRoute(
          path: '/', // Route untuk SplashScreen
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/login', // Route untuk LoginScreen
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/register', // Route untuk RegisterScreen
          builder: (context, state) => RegisterScreen(),
        ),
        GoRoute(
          path: '/home', // Route untuk HomeScreen
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/result', // Route untuk ResultScreen
          builder: (context, state) => ResultScreen(
              imagePath:
                  state.extra as String), // Menerima imagePath sebagai argumen
        ),
        GoRoute(
          path: '/resultDetection',
          builder: (context, state) => ScanResultScreen(
            imagePath: state.extra as String,
          ), // Tambahkan rute ke layar ScanResultScreen
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) =>
              ProfileScreen(), // Tambahkan rute ke layar ScanResultScreen
        ),
        GoRoute(
          path: '/profileEdit',
          builder: (context, state) =>
              EditProfileScreen(), // Tambahkan rute ke layar ScanResultScreen
        ),
        GoRoute(
          path: '/changePassword',
          builder: (context, state) =>
              ChangePasswordScreen(), // Tambahkan rute ke layar ScanResultScreen
        ),
        GoRoute(
            path: '/resetPassword',
            builder: (context, state) => ResetPasswordScreen() //
            ),
        GoRoute(
            path: '/pageOTP',
            builder: (context, state) => VerificationCodeScreen() //
            ),
         GoRoute(
            path: '/newPassword',
            builder: (context, state) => EnterNewPasswordScreen() //
            ),
         GoRoute(
            path: '/success',
            builder: (context, state) => SuccessChangePasswordScreen() //
            ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false, // Menghilangkan tulisan "debug"
      title: 'CitrusScan',
      theme: ThemeData(
        primarySwatch:
            createMaterialColor(Color(0xFF215C3C)), // Warna utama hijau
      ),
      routerDelegate:
          _router.routerDelegate, // Menggunakan router delegate dari GoRouter
      routeInformationParser:
          _router.routeInformationParser, // Parser route dari GoRouter
      routeInformationProvider:
          _router.routeInformationProvider, // Provider route dari GoRouter
    );
  }

  // Fungsi untuk membuat MaterialColor dari Color
  MaterialColor createMaterialColor(Color color) {
    List<double> strengths = <double>[.05]; // Daftar tingkat kekuatan warna
    Map<int, Color> swatch = {}; // Peta untuk menyimpan variasi warna
    final int r = color.red,
        g = color.green,
        b = color.blue; // Ambil komponen RGB dari warna

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
