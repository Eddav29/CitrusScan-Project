import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/provider/provider.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Color backgroundColor;

  CustomAppBar({required this.backgroundColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment
            .center, // Pastikan elemen sejajar secara vertikal
        children: [
          // Menampilkan logo di sebelah kiri
          Container(
            padding: EdgeInsets.all(
                4), // Memberikan padding agar logo tidak terlalu rapat dengan batas
            decoration: BoxDecoration(
              color: Colors.white, // Warna background logo putih
              shape: BoxShape.circle, // Bentuk bulat untuk logo
            ),
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/logo.png'), // Logo aplikasi
              radius: 22, // Ukuran logo lebih besar agar terlihat jelas
            ),
          ),
          SizedBox(width: 12), // Memberikan spasi antara logo dan teks

          // Teks sambutan di sebelah kanan logo
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Teks akan terposisikan ke kiri
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 6), // Menjaga jarak antar elemen
                  child: Text(
                    "Selamat Datang!", // Teks utama
                    style: TextStyle(
                      fontSize: 18, // Ukuran font lebih besar untuk teks utama
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .black87, // Warna hitam yang sedikit lebih lembut untuk keterbacaan
                    ),
                  ),
                ),
                SizedBox(height: 4), // Mengatur jarak antara dua baris teks
                Text(
                  user?.name ?? 'Guest User', // Nama pengguna atau teks default
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors
                        .black54, // Warna teks lebih lembut untuk subjudul
                    fontSize: 14, // Ukuran font yang lebih kecil untuk subjudul
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      automaticallyImplyLeading:
          false, // Tidak menampilkan tombol 'Back' secara otomatis
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(80.0); // Ukuran tinggi AppBar disesuaikan dengan desain
}
