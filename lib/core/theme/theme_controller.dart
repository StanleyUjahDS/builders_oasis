import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  static const String _key = "theme_mode";

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  ThemeController() {
    _loadTheme(); // 🔥 load saved theme on startup
  }

  // 🔁 LOAD SAVED THEME
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_key);

    switch (themeString) {
      case "light":
        _themeMode = ThemeMode.light;
        break;
      case "dark":
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  // 💾 SAVE THEME
  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    String value;
    switch (mode) {
      case ThemeMode.light:
        value = "light";
        break;
      case ThemeMode.dark:
        value = "dark";
        break;
      default:
        value = "system";
    }

    await prefs.setString(_key, value);
  }

  // 🎨 SET THEME
  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    _saveTheme(mode); // 🔥 persist it
    notifyListeners();
  }

  // 🔄 TOGGLE
  void toggleTheme() {
    if (_themeMode == ThemeMode.dark) {
      setTheme(ThemeMode.light);
    } else {
      setTheme(ThemeMode.dark);
    }
  }
}