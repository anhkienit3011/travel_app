import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  static SharedPreferences? _prefs;
  LocalStorageHelper._internal();
  static final LocalStorageHelper _shared = LocalStorageHelper._internal();
  factory LocalStorageHelper() {
    return _shared;
  }

  Box<dynamic>? hiveBox;


  static initLocalStorageHelper() async {
    _shared.hiveBox = await Hive.openBox('TravolApp');
    _prefs = await SharedPreferences.getInstance();
  }

  static dynamic getValue(String key) {
    return _shared.hiveBox?.get(key);
  }

  static setValue(String key, dynamic val) {
    _shared.hiveBox?.put(key, val);
  }

  static deleteValue(String key) {
    _shared.hiveBox?.delete(key);
  }

  static Future<void> setLoginStatus(bool isLoggedIn) async {
    await _prefs?.setBool('isLoggedIn', isLoggedIn);
  }

  static bool isLoggedIn() {
    return _prefs?.getBool('isLoggedIn') ?? false;
  }

  static Future<void> logout() async {
    await _prefs?.remove('isLoggedIn');
  }

}
