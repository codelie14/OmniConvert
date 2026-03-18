import 'package:hive_flutter/hive_flutter.dart';

class SettingsService {
  static const String boxName = 'settings';
  static late Box _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(boxName);
  }

  static Future<void> setDarkMode(bool isDark) async {
    await _box.put('darkMode', isDark);
  }

  static bool isDarkMode() {
    try {
      return _box.get('darkMode', defaultValue: true);
    } catch (e) {
      return true;
    }
  }

  static Future<void> setLanguage(String langCode) async {
    await _box.put('language', langCode);
  }

  static String getLanguage() {
    try {
      return _box.get('language', defaultValue: 'fr');
    } catch (e) {
      return 'fr';
    }
  }
}
