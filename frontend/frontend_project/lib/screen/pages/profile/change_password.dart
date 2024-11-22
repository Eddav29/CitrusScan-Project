import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:citrus_scan/screen/common/widgets/navigation_bar.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xFF215C3C),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/profile'), // Navigate back to profile
        ),
        title: Text(
          'Changes Password',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomNavigationBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Ilustrasi gambar
            Container(
              height: 230,
              child: Center(
                child: Image.asset(
                  'assets/images/password.png', // Ganti dengan path gambar ilustrasi Anda
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Form Change Password
            Container(
              padding: EdgeInsets.all(20),
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
                  // Old Password Field
                  PasswordField(label: 'Old Password'),
                  SizedBox(height: 10),
                  // New Password Field
                  PasswordField(label: 'Password'),
                  SizedBox(height: 10),
                  // Confirm Password Field
                  PasswordField(label: 'Confirm Password'),
                  SizedBox(height: 20),
                  // Save Now Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Password change!')),
                                  );
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
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final String label;

  const PasswordField({required this.label});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: _toggleVisibility,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        // Ubah warna border dan teks menjadi hijau ketika aktif
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF215C3C), width: 2),
        ),
        labelStyle: TextStyle(color: Colors.grey[700]), // Warna default
        floatingLabelStyle:
            TextStyle(color: Color(0xFF215C3C)), // Warna saat label di atas
      ),
    );
  }
}
