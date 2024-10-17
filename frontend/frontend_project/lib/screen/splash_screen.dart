import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/citrusplants.jpeg', // Make sure the path to the image is correct
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          // Wrap Column with SingleChildScrollView for scrolling capability
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
              children: [
                // Add some vertical spacing to center content
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                Text(
                  "Aplikasi terbaik \nuntuk mendeteksi dan merawat \ntanaman citrus Anda.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: 'Gilroy', // Using Gilroy font
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                // Wrap ElevatedButton with SizedBox to set the width
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8, // Button width 80% of screen width
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16), // Button height
                    ),
                    onPressed: () {
                      context.go('/login');
                    },
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gilroy', // Using Gilroy font
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Wrap TextButton "Create an account" with SizedBox for width
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8, // Button width 80% of screen width
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16), // Button height
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.white.withOpacity(0.3)),
                      ),
                    ),
                    onPressed: () {
                      context.go('/register');
                    },
                    child: Text(
                      "Buat akun",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gilroy', // Using Gilroy font
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Add spacing below the buttons
              ],
            ),
          ),
        ],
      ),
    );
  }
}
