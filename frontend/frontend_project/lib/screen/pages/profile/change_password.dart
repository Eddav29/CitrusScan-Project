import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/screen/common/widgets/navigation_bar.dart';
import 'package:citrus_scan/controller/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:citrus_scan/data/model/user/profile/profile_state.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

Future<void> _handleChangePassword() async {
  if (!_formKey.currentState!.validate()) return;

  // Indikator loading
  setState(() {
    _isLoading = true;
  });

  final token = await _getToken();
  
  if (token == null) {
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to authenticate. Please log in again.')),
    );
    return;
  }

  await ref.read(profileControllerProvider.notifier).updatePassword(
        token,
        _oldPasswordController.text,
        _newPasswordController.text,
      );

  final state = ref.read(profileControllerProvider);

  setState(() {
    _isLoading = false; // Reset loading
  });

  if (state.isUpdated) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password updated successfully!')),
    );
    ref.read(profileControllerProvider.notifier).state =
        state.copyWith(isUpdated: false); // Reset isUpdated
    context.go('/profile');
  } else if (state.error != null) {
    if (state.error!.contains('old password')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Old password is incorrect.')),
      );
    } else if (state.error!.contains('validation')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('New password does not meet criteria.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error!)),
      );
    }
  }
}


  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

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
          'Change Password',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomNavigationBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
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
                    PasswordField(
                      label: 'Old Password',
                      controller: _oldPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your old password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // New Password Field
                    PasswordField(
                      label: 'New Password',
                      controller: _newPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // Confirm Password Field
                    PasswordField(
                      label: 'Confirm Password',
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your new password';
                        }
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Save Now Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleChangePassword,
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
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordField({
    required this.label,
    required this.controller,
    this.validator,
  });

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
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
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