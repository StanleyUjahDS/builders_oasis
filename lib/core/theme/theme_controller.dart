import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  static const String _key = "theme_mode";

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool _initialized = false;
  bool get initialized => _initialized;

  // ================= INIT =================
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_key);

    if (themeString == "light") {
      _themeMode = ThemeMode.light;
    } else if (themeString == "dark") {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }

    _initialized = true;
    notifyListeners();
  }

  // ================= SET THEME =================
  Future<void> setTheme(ThemeMode mode) async {
    _themeMode = mode;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _key,
      switch (mode) {
        ThemeMode.light => "light",
        ThemeMode.dark => "dark",
        ThemeMode.system => "system",
      },
    );

    notifyListeners();
  }
}