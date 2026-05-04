import 'package:flutter/material.dart';

import '/core/ui/scaffolds/gradient_scaffold.dart';
import '/core/theme/app_colors.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool biometricEnabled = false;

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          title: const Text("Security"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            const SizedBox(height: 10),

            // ================= CHANGE PASSWORD =================
            _tile(
              icon: Icons.lock_outline,
              title: "Change Password",
              subtitle: "Update your account password",
              onTap: () {},
            ),

            const SizedBox(height: 12),

            // ================= BIOMETRIC =================
            SwitchListTile(
              value: biometricEnabled,
              onChanged: (value) {
                setState(() {
                  biometricEnabled = value;
                });
              },
              title: const Text("Biometric Login"),
              subtitle: const Text("Fingerprint / Face unlock"),
              secondary: const Icon(Icons.fingerprint),
            ),

            const SizedBox(height: 25),

            // ================= INFO =================
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border(
                  top: BorderSide(
                    color: AppColors.red200.withOpacity(0.4),
                  ),
                  bottom: BorderSide(
                    color: AppColors.red200.withOpacity(0.4),
                  ),
                ),
              ),
              child: const Text(
                "Your security settings help protect your account and personal data.",
                style: TextStyle(fontSize: 13),
              ),
            ),

            const SizedBox(height: 30),

            // ================= DANGER ZONE =================
            const Text(
              "Danger Zone",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 10),

            _dangerTile(
              icon: Icons.delete_forever,
              title: "Delete Account",
              subtitle: "Permanently remove your account and data",
              onTap: () {
                _showDeleteDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ================= NORMAL TILE =================
  Widget _tile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.red200.withOpacity(0.5)),
          bottom: BorderSide(color: AppColors.red200.withOpacity(0.3)),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  // ================= DANGER TILE =================
  Widget _dangerTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.delete_forever, color: Colors.red),
        title: Text(
          title,
          style: const TextStyle(color: Colors.red),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.warning, color: Colors.red),
        onTap: onTap,
      ),
    );
  }

  // ================= CONFIRM DIALOG =================
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Account?"),
        content: const Text(
          "This action is permanent and cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: delete account logic
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}