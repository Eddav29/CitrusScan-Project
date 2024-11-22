import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:citrus_scan/screen/common/widgets/navigation_bar.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Lloyd Haynes');
  final TextEditingController _emailController =
      TextEditingController(text: 'callie_parisian@rosenbaum.ca');

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
          onPressed: () => context.go('/profile'), // Navigate back to profile
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
      body: Stack(
        children: [
          // Green background at the top
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: Color(0xFF215C3C),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
          ),
          // Scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                // Profile Picture Positioned at the border of the green and white card
                SizedBox(height: 80),
                Center(
                  child: Stack(
                    clipBehavior:
                        Clip.none, // Allow overflow for the profile picture
                    children: [
                      // White Card for Profile Information
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
                            SizedBox(
                                height:
                                    40), // Space for the floating profile picture
                            // Name and Email fields
                            ProfileField(label: 'Name', controller: _nameController),
                            SizedBox(height: 25),
                            ProfileField(label: 'Email', controller: _emailController),
                            SizedBox(height: 35),
                            // Save button in the middle with the same width as the text fields
                            SizedBox(
                              width: double.infinity, // Width same as TextField
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Profile update!')),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color(0xFF215C3C), // Button color
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Border radius 10
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
                      // Profile Picture Floating Above the White Card with Edit Icon
                      Positioned(
                        top: -50,
                        left: MediaQuery.of(context).size.width *
                            0.33, // Center the image
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 46,
                                backgroundImage:
                                    AssetImage('assets/images/fotoprofile.jpg'),
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
}

// Custom TextField for profile editing similar to the Change Password layout
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
        // Change border color and text color to green when active
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF215C3C), width: 2),
        ),
        labelStyle: TextStyle(color: Colors.grey[700]), // Default color
        floatingLabelStyle:
            TextStyle(color: Color(0xFF215C3C)), // Color when focused
      ),
    );
  }
}
