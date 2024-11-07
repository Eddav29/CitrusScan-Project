import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false; // Variable to store checkbox status
  bool _obscurePassword = true; // Variable to hide/show password
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      // Add your login logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background Image with Waves
            Stack(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/citrusplants.jpeg'), // Ensure correct path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 250,
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
                      GoRouter.of(context).go('/');
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      height: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Selamat Datang",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy', // Using Gilroy font
                      color: Color(0xFF215C3C),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Masuk ke akun anda sekarang",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Gilroy', // Using Gilroy font
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30),

                  // Username Field
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

                  // Password Field
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
                  SizedBox(height: 10),

                  // Remember Me and Forgot Password Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe, // Using variable for status
                            onChanged: (bool? value) {
                              setState(() {
                                _rememberMe = value!; // Change checkbox status
                              });
                            },
                            activeColor: Color(0xFF215C3C),
                          ),
                          Text("Ingat saya"),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // Action for Forgot Password button
                        },
                        child: Text(
                          "Lupa Sandi?",
                          style: TextStyle(color: Color(0xFF215C3C)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to /home route
                        context.go('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF215C3C),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Masuk",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Login with Google Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add your Google login logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Set background to white for Google style
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Color(0xFF215C3C)), // Border color
                        ),
                      ),
                      icon: Image.asset(
                        'assets/images/google.png', // Add the path to your Google icon
                        height: 24,
                        width: 24,
                      ),
                      label: Text(
                        "Login with Google",
                        style: TextStyle(
                          color: Color(0xFF215C3C), // Set text color to match theme
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Belum punya akun?"),
                      TextButton(
                        onPressed: () {
                          context.go('/register');
                        },
                        child: Text(
                          "Daftar",
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

// Class to create wave effect
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 120); // Memulai sedikit lebih tinggi
    path.quadraticBezierTo(
      size.width / 4, size.height - 100, // Menambahkan titik cembung di tengah
      size.width / 2, size.height - 110,
    );
    path.quadraticBezierTo(
      3 * size.width / 4, size.height, // Titik akhir cembung
      size.width, size.height - 90,
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
