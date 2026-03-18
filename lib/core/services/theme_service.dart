import 'package:flutter/material.dart';
import 'settings_service.dart';

class ThemeService extends ChangeNotifier {
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  ThemeMode get themeMode => SettingsService.isDarkMode() ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() async {
    await SettingsService.setDarkMode(!SettingsService.isDarkMode());
    notifyListeners();
  }
}
