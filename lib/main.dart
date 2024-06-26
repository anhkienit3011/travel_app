import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_app/representation/screen/splash_screen.dart';
import 'package:travel_app/representation/screen/login/login_screen.dart';
import 'package:travel_app/routes.dart';

import 'core/constants/color_constants.dart';
import 'core/helpers/local_storage_helper.dart';
import 'core/helpers/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TravoApp());
}

class TravoApp extends StatelessWidget {
  const TravoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travo App',
      theme: ThemeData(
        primaryColor: ColorPalette.primaryColor,
        scaffoldBackgroundColor: ColorPalette.backgroundScaffoldColor,
      ),
      routes: routes,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoutes,
      home: Builder(
        builder: (context) {
          SizeConfig.init(context); // Initialize SizeConfig here
          return SplashScreen(); // Start with the SplashScreen
        },
      ),
    );
  }
}
