import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme_controller_instance.dart';

class BuildersOasisApp extends StatefulWidget {
  const BuildersOasisApp({super.key});

  @override
  State<BuildersOasisApp> createState() => _BuildersOasisAppState();
}

class _BuildersOasisAppState extends State<BuildersOasisApp>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    themeController.addListener(_syncSystemUI);

    _syncSystemUI(); // 🔥 apply immediately on start
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // optional but useful for reminders
    if (state == AppLifecycleState.resumed) {
      _syncSystemUI();
    }
  }

  void _syncSystemUI() {
    final isDark = themeController.themeMode == ThemeMode.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
        isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness:
        isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor:
        isDark ? const Color(0xFF0A192F) : Colors.white,
        systemNavigationBarIconBrightness:
        isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    themeController.removeListener(_syncSystemUI);
    super.dispose();
  }

  ThemeMode _resolveThemeMode() {
    if (themeController.themeMode == ThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;

      return brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
    }
    return themeController.themeMode;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _resolveThemeMode(),

          routerConfig: AppRouter.router,
        );
      },
    );
  }
}