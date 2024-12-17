import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:citrus_scan/screen/common/widgets/navigation_bar.dart';
import 'package:citrus_scan/data/model/user/user.dart';
import 'package:citrus_scan/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final User user;

  EditProfileScreen({required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late User _user; // Simpan User di dalam state lokal
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inisialisasi state lokal _user dengan widget.user
    _user = widget.user;
    _nameController.text = _user.name;
    _emailController.text = _user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xFF215C3C),
        elevation: 0,
        title: Text('Edit Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              context.go('/profile'), // Navigasi kembali ke profile
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
      body: Stack(
        children: [
          // Background hijau di bagian atas
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: Color(0xFF215C3C),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
          ),
          // Konten scrollable
          SingleChildScrollView(
            child: Column(
              children: [
                // Gambar profil mengambang di atas card putih
                SizedBox(height: 80),
                Center(
                  child: Stack(
                    clipBehavior: Clip.none, // Biarkan gambar mengambang
                    children: [
                      // Card putih untuk informasi profil
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding:
                            EdgeInsets.symmetric(vertical: 60, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            // Kolom untuk edit Nama dan Email
                            ProfileField(
                                label: 'Name', controller: _nameController),
                            SizedBox(height: 25),
                            ProfileField(
                                label: 'Email', controller: _emailController),
                            SizedBox(height: 35),
                            // Tombol simpan
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final token =
                                      await _getToken(); // Ambil token dari SharedPreferences

                                  if (token != null) {
                                    // Panggil fungsi untuk memperbarui profil
                                    await ref
                                        .read(
                                            profileControllerProvider.notifier)
                                        .updateProfile(
                                          token,
                                          name: _nameController.text,
                                          email: _emailController.text,
                                        );

                                    // Setelah berhasil, tampilkan SnackBar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Profile updated!')));

                                    // Update _user dengan salinan baru menggunakan copyWith
                                    final updatedUser = _user.copyWith(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                    );

                                    // Simpan updatedUser ke SharedPreferences
                                    await _saveUserToPrefs(updatedUser);

                                    // Ambil user terbaru dari SharedPreferences
                                    final newUser = await _getUserFromPrefs();

                                    // Navigasi ke ProfileScreen setelah update
                                    context.go('/profile');
                                  } else {
                                    // Tangani jika token tidak ditemukan
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Token not found')));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF215C3C),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Foto Profil yang mengambang di atas card putih
                      Positioned(
                        top: -50,
                        left: MediaQuery.of(context).size.width * 0.33,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 46,
                                backgroundImage: _user.profilePicture != null
                                    ? NetworkImage(_user.profilePicture!)
                                    : AssetImage(
                                            'assets/images/fotoprofile.jpg')
                                        as ImageProvider,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xFF215C3C),
                                child: Icon(Icons.camera_alt,
                                    size: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk mengambil token dari SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Fungsi untuk menyimpan user yang sudah diupdate ke SharedPreferences
  Future<void> _saveUserToPrefs(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  // Fungsi untuk mengambil user dari SharedPreferences
  Future<User?> _getUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }
}

// Custom TextField untuk pengeditan profil
class ProfileField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const ProfileField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF215C3C), width: 2),
        ),
        labelStyle: TextStyle(color: Colors.grey[700]),
        floatingLabelStyle:
            TextStyle(color: Color(0xFF215C3C)), // Warna saat fokus
      ),
    );
  } 
}
