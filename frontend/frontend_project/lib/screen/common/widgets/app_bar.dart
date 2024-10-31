import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;

  CustomAppBar({required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor, // Menentukan warna latar belakang AppBar
      elevation: 0, // Menghilangkan bayangan pada AppBar
      title: Row(
        children: [
          // Menampilkan logo di sebelah kiri
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Mengatur warna background logo menjadi putih
              shape: BoxShape.circle, // Membuat background berbentuk bulat
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'), // Menggunakan logo dari folder assets
              radius: 20, // Ukuran logo
            ),
          ),
          SizedBox(width: 10), // Spasi antara logo dan teks
          
          // Teks sambutan di sebelah kanan logo
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks berposisi ke kiri
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 7), // Jarak teks dari atas
                child: Text(
                  "Selamat Datang!", // Teks utama
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Warna teks hitam
                  ),
                ),
              ),
              SizedBox(height: 6), // Jarak antara dua baris teks
              Text(
                "Sekawan Limo", // Teks kedua (nama pengguna atau perusahaan)
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black, // Warna teks hitam
                ),
              ),
            ],
          ),
        ],
      ),
      automaticallyImplyLeading: false, // Tidak menampilkan tombol 'Back' secara otomatis
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0); // Ukuran tinggi AppBar
}
