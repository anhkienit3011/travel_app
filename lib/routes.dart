// lib/routes.dart

import 'package:flutter/material.dart';
import 'package:travel_app/representation/screen/check_out_screen.dart';
import 'package:travel_app/representation/screen/detail_hotel_screen.dart';
import 'package:travel_app/representation/screen/guest_and_room_screen.dart';
import 'package:travel_app/representation/screen/hotel_booking_screen.dart';
import 'package:travel_app/representation/screen/hotels_screen.dart';
import 'package:travel_app/representation/screen/login/login_screen.dart';
import 'package:travel_app/representation/screen/login/signup_screen.dart';
import 'package:travel_app/representation/screen/main_app.dart';
import 'package:travel_app/representation/screen/profile_screen.dart';
import 'package:travel_app/representation/screen/rooms_screen.dart';
import 'package:travel_app/representation/screen/select_date_screen.dart';
import 'package:travel_app/representation/screen/splash_screen.dart';

import 'data/model/hotel_model.dart';
import 'data/model/room_model.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  MainApp.routeName: (context) => MainApp(),
  LoginScreen.routeName: (context) => LoginScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  HotelsScreen.routeName: (context) => HotelsScreen(),
  SelectDateScreen.routeName: (context) => SelectDateScreen(),
  GuestAndRoomScreen.routeName: (context) => GuestAndRoomScreen(),
  RoomsScreen.routeName: (context) => RoomsScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ChatScreen.routeName: (context) => ChatScreen(),
};

MaterialPageRoute<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case DetailHotelScreen.routeName:
      final HotelModel hotelModel = (settings.arguments as HotelModel);
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => DetailHotelScreen(
          hotelModel: hotelModel,
        ),
      );
    case CheckOutScreen.routeName:
      final RoomModel roomModel = (settings.arguments as RoomModel);
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => CheckOutScreen(
          roomModel: roomModel,
        ),
      );
    case HotelBookingScreen.routeName:
      final String? destination = (settings.arguments as String?);
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => HotelBookingScreen(
          destination: destination,
        ),
      );
    default:
      return null;
  }
}