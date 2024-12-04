import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';

class VerificationCodeScreen extends StatefulWidget {
  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(4, (_) => FocusNode());

  late Timer _timer;
  int _remainingTime = 120; // Timer 5 menit (300 detik)

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  void _onCodeInputChange(int index, String value) {
    if (value.isNotEmpty && RegExp(r'^\d$').hasMatch(value)) {
      if (index < _focusNodes.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else {
      _controllers[index].clear();
    }
  }

  bool _isCodeComplete() {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }

  String _getEnteredCode() {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan gambar dan gradient
            Stack(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/citrusplants.jpeg'),
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
                    icon: Icon(Icons.arrow_back, color: Color(0xFF215C3C)),
                    onPressed: () => context.go('/login'),
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
            SizedBox(height: 40),

            // Teks judul
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Masukkan Kode Verifikasi",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      color: Color(0xFF215C3C),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Kami mengirimkan kode ke email Anda. Harap periksa kotak masuk Anda.",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30),

                  // Input kode OTP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (index) => Container(
                        width: 50,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF215C3C), width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 20),
                            maxLength: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            onChanged: (value) =>
                                _onCodeInputChange(index, value),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Timer
                  Center(
                    child: Text(
                      _formatTime(_remainingTime),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF215C3C),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Tombol kirim ulang kode
                  Center(
                    child: TextButton(
                      onPressed: _remainingTime == 0
                          ? () {
                              setState(() {
                                _remainingTime = 120;
                                _startTimer();
                              });
                            }
                          : null,
                      child: Text(
                        "Tidak menerima kode? Kirim ulang",
                        style: TextStyle(
                          color: _remainingTime == 0
                              ? Color(0xFF215C3C)
                              : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // Tombol verifikasi
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF215C3C),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isCodeComplete()
                          ? () {
                              final enteredCode = _getEnteredCode();
                              if (enteredCode == "9999") {
                                context.go('/newPassword'); // Navigasi ke halaman sukses
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Kode OTP salah!'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          : null,
                      child: Text(
                        'Verifikasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 120);
    path.quadraticBezierTo(
      size.width / 4,
      size.height - 100,
      size.width / 2,
      size.height - 110,
    );
    path.quadraticBezierTo(
      3 * size.width / 4,
      size.height,
      size.width,
      size.height - 90,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
