import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier{
  ThemeMode mode;
  String locale;
  SettingsProvider(): mode = ThemeMode.light,locale = 'en';
  void changeLocale(String locale){
    this.locale = locale;
    notifyListeners();
  }
  void changeMode(ThemeMode mode){
    this.mode = mode;
    notifyListeners();
  }
}
