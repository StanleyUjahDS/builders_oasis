import 'package:flutter/material.dart';
import '../../core/theme/theme_controller.dart';

class ThemeSettingsPage extends StatelessWidget {
  final ThemeController themeController;

  const ThemeSettingsPage({
    super.key,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Settings"),
      ),

      // ONLY CONTENT ON PAGE
      body: ListView(
        children: [
          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.phone_android),
            title: const Text("System Theme"),
            subtitle: const Text("Follow device settings"),
            onTap: () {
              themeController.setTheme(ThemeMode.system);
            },
          ),

          ListTile(
            leading: const Icon(Icons.light_mode),
            title: const Text("Light Mode"),
            subtitle: const Text("Always use light theme"),
            onTap: () {
              themeController.setTheme(ThemeMode.light);
            },
          ),

          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Dark Mode"),
            subtitle: const Text("Always use dark theme"),
            onTap: () {
              themeController.setTheme(ThemeMode.dark);
            },
          ),

          const SizedBox(height: 20),

          Divider(
            color: theme.dividerColor,
          ),

          const SizedBox(height: 10),

          Center(
            child: Text(
              "Choose your preferred appearance",
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}