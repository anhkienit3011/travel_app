import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/representation/screen/chat_screen.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dismension_constants.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  static const routeName = '/main_app';

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ChatScreen(), // Chatbot screen
    Container(), // Placeholder for Booking screen
    ProfileScreen(), // Profile screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: ColorPalette.primaryColor,
        unselectedItemColor: ColorPalette.primaryColor.withOpacity(0.2),
        selectedColorOpacity: 0.2,
        margin: EdgeInsets.symmetric(horizontal: kMediumPadding, vertical: kDefaultPadding),
        items: [
          SalomonBottomBarItem(
            icon: Icon(
              FontAwesomeIcons.house,
              size: kDefaultPadding,
            ),
            title: Text("Home"),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              FontAwesomeIcons.robot,
              size: kDefaultPadding,
            ),
            title: Text("Chatbot"),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              FontAwesomeIcons.briefcase,
              size: kDefaultPadding,
            ),
            title: Text("Booking"),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              FontAwesomeIcons.solidUser,
              size: kDefaultPadding,
            ),
            title: Text("Profile"),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
    );
  }
}
