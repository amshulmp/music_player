// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _keyIsdarkmode = 'isdarkmode';

  static Future<void> savemodeStatus(bool isdarkmode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_keyIsdarkmode, isdarkmode);
  }
  static Future<bool> getmodeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsdarkmode) ?? false;
  }
  static Future<void> clearmodeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyIsdarkmode);
  }
}
