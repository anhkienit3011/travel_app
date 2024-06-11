import 'package:flutter/material.dart';
import 'package:travel_app/core/helpers/local_storage_helper.dart';
import 'package:travel_app/representation/screen/login_screen.dart';
import 'package:travel_app/representation/screen/main_app.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await LocalStorageHelper.isLoggedIn();

    // Added delay for splash screen effect; remove or adjust as needed
    await Future.delayed(Duration(seconds: 2));

    if (isLoggedIn) {
      Navigator.of(context).pushReplacementNamed(MainApp.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Replace with your splash screen content
      ),
    );
  }
}
