import 'package:flutter/material.dart';
import 'package:music_player/utilities/sharedpreference.dart';
import 'package:music_player/utilities/themes.dart';

class Themeprovider extends ChangeNotifier {
  ThemeData _themeData = lightmode;
 Themeprovider({bool initialDarkMode = false}) {
    if (initialDarkMode) {
      _themeData = darkmode;
    }
  }
  ThemeData get themeData => _themeData;

  bool get isdarkmode => _themeData == darkmode;

  set themeData(ThemeData newThemeData) {
    _themeData = newThemeData;
    notifyListeners();
  }

 void toggleTheme() {
    if (_themeData == lightmode) {
      themeData = darkmode;
      SharedPreferencesHelper.savemodeStatus(true);
    } else {
      themeData = lightmode;
      SharedPreferencesHelper.savemodeStatus(false);
      
    }
  }
}
