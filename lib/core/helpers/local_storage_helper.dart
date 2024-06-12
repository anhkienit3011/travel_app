import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {

  static SharedPreferences? _prefs;
  static Box<dynamic>? _hiveBox;

  LocalStorageHelper._internal();
  static final LocalStorageHelper _shared = LocalStorageHelper._internal();
  factory LocalStorageHelper() {
    return _shared;
  }

  static Future<void> initLocalStorageHelper() async {
    _prefs = await SharedPreferences.getInstance();
    _hiveBox = await Hive.openBox('TravoApp');
  }

  static dynamic getValue(String key) {
    return _hiveBox?.get(key);
  }

  static Future<void> setValue(String key, dynamic val) async {
    await _hiveBox?.put(key, val);
  }

  static Future<void> deleteValue(String key) async {
    await _hiveBox?.delete(key);
  }

  static Future<void> setLoginStatus(bool isLoggedIn) async {
    await _prefs?.setBool('isLoggedIn', isLoggedIn);
  }

  static Future<bool> isLoggedIn() async {
    if (_prefs != null) {
      return _prefs!.getBool('isLoggedIn') ?? false;
    } else {
      return false;
    }
  }

  static Future<void> logout() async {
    await _prefs?.remove('isLoggedIn');
  }
}
