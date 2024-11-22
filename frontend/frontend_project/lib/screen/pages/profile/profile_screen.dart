import 'package:flutter/material.dart';
import '../../common/widgets/navigation_bar.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? selectedSetting; // To keep track of the selected setting

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xFF215C3C),
        elevation: 0,
      ),
      bottomNavigationBar: CustomNavigationBar(),
      body: Stack(
        children: [
          // Green background with curved bottom
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Color(0xFF215C3C),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
          ),
          // Scrollable content
          SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0), // Reduced top padding
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
                      // Profile Picture
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/fotoprofile.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Name and Email
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Ricardo Joseph',
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
                                  'ricardojoseph@gmail.com',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // Divider between Profile and Settings
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                      SizedBox(height: 10),
                      // Settings Header
                      Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Profile Settings Section
                      _buildSettingsSection(
                        icon: Icons.edit,
                        title: 'Edit Profile',
                        subtitle: 'Update and modify your profile',
                        identifier: 'edit_profile',
                      ),
                      SizedBox(height: 10),
                      // Privacy Section
                      _buildSettingsSection(
                        icon: Icons.lock,
                        title: 'Privacy',
                        subtitle: 'Change your password',
                        identifier: 'change_password',
                      ),
                      SizedBox(height: 10),
                      // Logout Section
                      _buildSettingsSection(
                        icon: Icons.logout,
                        title: 'Logout',
                        subtitle: 'Logout from your account',
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

  // Helper widget to build settings sections
  Widget _buildSettingsSection({
    required IconData icon,
    required String title,
    required String subtitle,
    required String identifier,
  }) {
    final isSelected = selectedSetting == identifier;
    final isLogout = identifier == 'logout';

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSetting = identifier;
          if (identifier == 'logout') {
            // Add a delay before navigating to avoid flickering effect
            Future.delayed(Duration(milliseconds: 300), () {
              context.go('/login'); // Navigate to login screen after a delay
            });
          } else if (identifier == 'edit_profile') {
            context.go('/profileEdit'); // Replace with your desired route
          } else if (identifier == 'change_password') {
            context.go('/changePassword'); // Replace with your desired route
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? (isLogout ? Colors.red : Color(0xFF215C3C)) : Colors.white,
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
            backgroundColor: isSelected ? Colors.white : (isLogout ? Colors.red[100] : Colors.grey[200]),
            child: Icon(
              icon,
              color: isLogout ? Colors.red : (isSelected ? Color(0xFF215C3C) : Color(0xFF215C3C)),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isSelected ? (isLogout ? Colors.white : Colors.white) : (isLogout ? Colors.red : Colors.black87),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: isSelected ? (isLogout ? Colors.white70 : Colors.white70) : (isLogout ? Colors.red[300] : Colors.black54),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: isSelected ? (isLogout ? Colors.white : Colors.white) : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
