import 'package:flutter/material.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';
import '/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        // ================= APP BAR =================
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Settings",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () {
                context.push("/profile");
              },
            ),
          ],
        ),

        // ================= BODY =================
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ================= ACCOUNT =================
            _sectionTitle("Account"),

            _settingsTile(
              icon: Icons.person_outline,
              title: "Profile",
              description: "Edit your personal details",
              onTap: () => context.push("/profile"),
            ),

            _settingsTile(
              icon: Icons.lock_outline,
              title: "Security",
              description: "Password & authentication",
              onTap: () => context.push("/security"),
            ),

            _settingsTile(
              icon: Icons.notifications_none,
              title: "Notifications",
              description: "Alerts and updates",
              onTap: () => context.push("/notifications"),
            ),

            const SizedBox(height: 20),



// ================= APP =================
            _sectionTitle("App"),

            _settingsTile(
              icon: Icons.dark_mode_outlined,
              title: "Theme",
              description: "Light / Dark mode",
              onTap: () => context.push("/theme"),
            ),

            _settingsTile(
              icon: Icons.language,
              title: "Language",
              description: "English (UK)",
              onTap: () => context.push("/language"),
            ),

            _settingsTile(
              icon: Icons.help_outline,
              title: "Help & Support",
              description: "Get assistance",
              onTap: () => context.push("/support"),
            ),
            const SizedBox(height: 30),

            // ================= LOGOUT =================
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.red200,
                  ),
                  bottom: BorderSide(
                    color: AppColors.red200,
                  ),
                ),
              ),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  context.go('/login');
                },
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // ================= SECTION TITLE =================
  static Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ================= SETTINGS TILE =================
  static Widget _settingsTile({
    required IconData icon,
    required String title,
    String? description,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.red200,
            width: 1.2,
          ),
          bottom: BorderSide(
            color: AppColors.red200.withOpacity(0.4),
            width: 1.2,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),

        title: Text(title),

        subtitle: description != null
            ? Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        )
            : null,

        trailing: const Icon(Icons.arrow_forward_ios, size: 16),

        onTap: onTap,
      ),
    );
  }
}