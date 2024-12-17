import 'dart:convert';
import 'package:citrus_scan/data/model/user/user.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/navigation_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String? selectedSetting;
  String? updateMessage;
  User? user; // Menambahkan variabel untuk menyimpan user

  @override
  void initState() {
    super.initState();
    // Memanggil fungsi untuk mengambil user dari SharedPreferences
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Menangkap parameter tambahan dari navigasi (misalnya "Profile updated!")
    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    if (arguments != null && arguments.containsKey('message')) {
      updateMessage = arguments['message'] as String;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF215C3C),
      ),
      bottomNavigationBar: CustomNavigationBar(),
      body: Stack(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Color(0xFF215C3C),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
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
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (user != null) ...[
                        // Pastikan user sudah ada sebelum menampilkan data
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: ClipOval(
                              child: user?.profilePicture != null
                                  ? Image.network(
                                      user?.profilePicture ?? '',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/fotoprofile.jpg',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                user?.name ?? 'Tamu',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user?.email ?? 'Tidak ada email',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  SizedBox(width: 5),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: 20),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                      SizedBox(height: 10),
                      if (updateMessage != null)
                        // Menampilkan SnackBar atau pesan sukses di atas
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SnackBar(
                            content: Text(updateMessage!),
                            backgroundColor: Colors.green,
                          ),
                        ),
                      Text(
                        'Pengaturan',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Bagian Pengaturan Profil
                      _buildSettingsSection(
                        icon: Icons.edit,
                        title: 'Edit Profil',
                        subtitle: 'Perbarui dan ubah profil Anda',
                        identifier: 'edit_profile',
                        user: user, // Kirim data user
                      ),
                      SizedBox(height: 10),
                      _buildSettingsSection(
                        icon: Icons.lock,
                        title: 'Privasi',
                        subtitle: 'Ganti kata sandi Anda',
                        identifier: 'change_password',
                      ),
                      SizedBox(height: 10),
                      _buildSettingsSection(
                        icon: Icons.logout,
                        title: 'Keluar',
                        subtitle: 'Keluar dari akun Anda',
                        identifier: 'logout',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection({
    required IconData icon,
    required String title,
    required String subtitle,
    required String identifier,
    User? user, // Tambahkan parameter user
  }) {
    final isSelected = selectedSetting == identifier;
    final isLogout = identifier == 'logout';

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSetting = identifier;
          if (identifier == 'logout') {
            Future.delayed(Duration(milliseconds: 300), () {
              _handleLogout();
            });
          } else if (identifier == 'edit_profile') {
            if (user != null) {
              // Pastikan user tidak null
              context.go('/profileEdit', extra: user); // Kirim data user
            }
          } else if (identifier == 'change_password') {
            context.go('/changePassword');
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? (isLogout ? Colors.red : Color(0xFF215C3C))
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isSelected ? Colors.black26 : Colors.black12,
              blurRadius: isSelected ? 8 : 4,
              offset: Offset(0, isSelected ? 6 : 2),
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: isSelected
                ? Colors.white
                : (isLogout ? Colors.red[100] : Colors.grey[200]),
            child: Icon(
              icon,
              color: isLogout
                  ? Colors.red
                  : (isSelected ? Colors.white : Color(0xFF215C3C)),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: isSelected
                  ? (isLogout ? Colors.white : Colors.white)
                  : (isLogout ? Colors.red : Colors.black87),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 15.0,
              color: isSelected
                  ? (isLogout ? Colors.black54 : Colors.white70)
                  : (isLogout ? Colors.red[300] : Colors.black54),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: isSelected
                ? (isLogout ? Colors.white : Colors.white)
                : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  void _handleLogout() async {
    final authController = ref.read(authControllerProvider.notifier);
    await authController.logout();
    if (mounted) {
      context.go('/login');
    }
  }
}
