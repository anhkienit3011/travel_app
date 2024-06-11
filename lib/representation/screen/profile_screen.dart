// lib/representation/screen/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:travel_app/core/helpers/local_storage_helper.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder image
              backgroundColor: Colors.grey[200],
            ),
            SizedBox(height: 20),
            Text(
              'User Name', // Placeholder text
              style: Theme.of(context).textTheme.titleLarge?.copyWith( // Use titleLarge instead of headline6
                fontWeight: FontWeight.bold,
                color: ColorPalette.primaryColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'user@example.com', // Placeholder text
              style: Theme.of(context).textTheme.bodyLarge?.copyWith( // Use bodyLarge instead of subtitle1
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.edit, color: ColorPalette.primaryColor),
              title: Text('Edit Profile'),
              onTap: () {
                // Handle edit profile
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: ColorPalette.primaryColor),
              title: Text('Settings'),
              onTap: () {
                // Handle settings
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout'),
              onTap: () async {
                await LocalStorageHelper.logout();
                Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
