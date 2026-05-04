import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';
import '/core/theme/theme_controller_instance.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final current = themeController.themeMode;
    final theme = Theme.of(context);

    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        // ================= APP BAR =================
        appBar: AppBar(
          title: const Text(
            "Theme Settings",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        // ================= BODY =================
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            const SizedBox(height: 10),

            Text(
              "Choose your preferred appearance",
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 20),

            _tile(
              title: "System Theme",
              subtitle: "Follows your device settings",
              icon: Icons.phone_android,
              mode: ThemeMode.system,
              current: current,
            ),

            _tile(
              title: "Light Mode",
              subtitle: "Always use light theme",
              icon: Icons.light_mode,
              mode: ThemeMode.light,
              current: current,
            ),

            _tile(
              title: "Dark Mode",
              subtitle: "Always use dark theme",
              icon: Icons.dark_mode,
              mode: ThemeMode.dark,
              current: current,
            ),
          ],
        ),
      ),
    );
  }

  // ================= TILE =================
  Widget _tile({
    required String title,
    required String subtitle,
    required IconData icon,
    required ThemeMode mode,
    required ThemeMode current,
  }) {
    final selected = mode == current;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border(
          top: BorderSide(
            color: AppColors.red200.withOpacity(0.5),
            width: 1.2,
          ),
          bottom: BorderSide(
            color: AppColors.red200.withOpacity(0.5),
            width: 1.2,
          ),
        ),
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),

        leading: Icon(
          icon,
          color: selected ? AppColors.red500 : Colors.grey,
        ),

        title: Text(
          title,
          style: TextStyle(
            fontWeight: selected ? FontWeight.bold : FontWeight.w500,
          ),
        ),

        subtitle: Text(subtitle),

        trailing: selected
            ? const Icon(Icons.check_circle, color: Colors.red)
            : const Icon(Icons.circle_outlined, color: Colors.grey),

        onTap: () {
          themeController.setTheme(mode);
        },
      ),
    );
  }
}