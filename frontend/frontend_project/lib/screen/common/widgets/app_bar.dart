import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:citrus_scan/data/model/user/user.dart';

class CustomAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final Color backgroundColor;

  CustomAppBar({required this.backgroundColor});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(80.0);
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  User? user;

  @override
  void initState() {
    super.initState();
    _getUserFromPrefs();
  }

  // Fungsi untuk mengambil user dari SharedPreferences
  Future<void> _getUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      setState(() {
        user = User.fromJson(jsonDecode(userJson)); // Mengupdate state user
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor,
      elevation: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
              radius: 22,
            ),
          ),
          SizedBox(width: 12),

          // Teks sambutan di sebelah kanan logo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    "Selamat Datang!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  user?.name ??
                      'Guest User', // Tampilkan nama user dari SharedPreferences
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      automaticallyImplyLeading: false,
    );
  }
}
