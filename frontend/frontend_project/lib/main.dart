import 'package:citrus_scan/screen/camera_screen.dart';
import 'package:citrus_scan/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/camera', 
          builder: (context, state) => const CameraScreen(),
        ),
      ]
    );
    
    return MaterialApp.router(
      title: 'Citrus Scan',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
