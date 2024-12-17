import 'package:citrus_scan/screen/pages/scan/scan_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:citrus_scan/screen/pages/scan/widgets/scan_option_modal.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends StatefulWidget {
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _currentIndex = 0; // Melacak indeks yang dipilih saat ini
  final ImagePicker _picker = ImagePicker();

  // Function to handle picking from camera or gallery
  Future<void> _handleImageSelection() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScanResultScreen(imagePath: image.path),
        ),
      );
    }
  }

  Future<void> _handleCameraCapture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScanResultScreen(imagePath: photo.path),
        ),
      );
    }
  }

  // Function to show the modal using the separated widget
  void _showScanOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ScanOptionsModal(
          onImageSourceSelected: (ImageSource source) {
            if (source == ImageSource.gallery) {
              _handleImageSelection();
            } else if (source == ImageSource.camera) {
              _handleCameraCapture();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check the current route path using GoRouter's currentConfiguration.fullPath
    final currentPath =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    // Default to 0 if no valid route matches
    if (currentPath == '/home') {
      _currentIndex = 0;
    } else if (currentPath == '/profile' ||
        currentPath == '/profileEdit' ||
        currentPath == '/changePassword') {
      _currentIndex = 1;
    } else {
      _currentIndex = 0; // Default to home if no matching path
    }

    return Stack(
      clipBehavior: Clip.none, // Mencegah elemen terpotong di luar batas
      children: [
        BottomNavigationBar(
          currentIndex: _currentIndex, // Menandai item mana yang sedang aktif
          onTap: (index) {
            setState(() {
              _currentIndex =
                  index; // Mengubah indeks yang dipilih saat item ditekan
            });

            // Penanganan navigasi untuk Home dan Profile menggunakan go_router
            if (index == 0) {
              context.go('/home'); // Navigasi ke HomeScreen
            } else if (index == 1) {
              context.go('/profile'); // Navigasi ke ProfileScreen
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _currentIndex == 0
                    ? Color(0xFF215C3C)
                    : Colors.grey, // Warna hijau jika aktif
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _currentIndex == 1
                    ? Color(0xFF215C3C)
                    : Colors.grey, // Warna hijau jika aktif
              ),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.fixed, // Jenis navigasi bar tetap
          backgroundColor: Colors.white, // Warna latar belakang bar navigasi
          elevation: 0, // Menghilangkan efek bayangan
          selectedItemColor:
              Color(0xFF215C3C), // Warna item yang dipilih (hijau)
          unselectedItemColor:
              Colors.grey, // Warna item yang tidak dipilih (abu-abu)
        ),
        Positioned(
          top: -30, // Posisi tombol melayang di atas navbar
          left: MediaQuery.of(context).size.width * 0.5 -
              28, // Pusatkan tombol di navbar
          child: FloatingActionButton(
            onPressed: _showScanOptions,
            backgroundColor: Color(0xFF215C3C), // Warna tombol (hijau)
            child: Icon(Icons.center_focus_strong,
                size: 30, color: Colors.white), // Ikon untuk tombol scan
            elevation: 2, // Memberikan sedikit bayangan untuk tombol
          ),
        ),
      ],
    );
  }
}
