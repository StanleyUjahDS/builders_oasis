import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'core/router/app_router.dart';

class BuildersOasisApp extends StatefulWidget {
  const BuildersOasisApp({super.key});

  @override
  State<BuildersOasisApp> createState() => _BuildersOasisAppState();
}

class _BuildersOasisAppState extends State<BuildersOasisApp> {
  final ThemeController themeController = ThemeController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,

          // 🎨 THEME
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,

          // 🚀 ROUTER (GO ROUTER ACTIVE)
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
