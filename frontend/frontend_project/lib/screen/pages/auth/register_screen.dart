import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true; // For hiding/showing password
  bool _obscureConfirmPassword = true; // For hiding/showing confirm password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background image with gradient
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35, // Dynamic height based on screen size
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/citrusplants.jpeg'), // Ensure the path is correct
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.5), Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 16,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xFF215C3C)), // Change color
                    onPressed: () {
                      context.go('/'); // Navigate back to the previous screen
                    },
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Daftar Akun Baru",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy', // Using Gilroy font
                      color: Color(0xFF215C3C),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Silakan isi data di bawah ini",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Gilroy', // Using Gilroy font
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30),

                  // Username field
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Color(0xFF215C3C)),
                      hintText: "Nama Pengguna",
                      fillColor: Color(0xFF215C3C).withOpacity(0.1),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Email field
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Color(0xFF215C3C)),
                      hintText: "Email",
                      fillColor: Color(0xFF215C3C).withOpacity(0.1),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Password field
                  TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Color(0xFF215C3C)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Color(0xFF215C3C),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword; // Toggle password visibility
                          });
                        },
                      ),
                      hintText: "Kata Sandi",
                      fillColor: Color(0xFF215C3C).withOpacity(0.1),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Confirm Password field
                  TextField(
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Color(0xFF215C3C)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                          color: Color(0xFF215C3C),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword; // Toggle password visibility
                          });
                        },
                      ),
                      hintText: "Konfirmasi Kata Sandi",
                      fillColor: Color(0xFF215C3C).withOpacity(0.1),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Register button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Action for the Register button
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF215C3C),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Daftar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sudah punya akun?"),
                      TextButton(
                        onPressed: () {
                          context.go('/login');
                        },
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                            color: Color(0xFF215C3C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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

// Class for creating wave effect
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 4, size.height - 30,
      size.width / 2, size.height - 10,
    );
    path.quadraticBezierTo(
      3 / 4 * size.width, size.height + 20,
      size.width, size.height - 10,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
