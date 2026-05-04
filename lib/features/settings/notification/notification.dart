import 'package:flutter/material.dart';

import '/core/ui/scaffolds/gradient_scaffold.dart';
import '/core/theme/app_colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool courseUpdates = true;
  bool newLessons = true;
  bool promotions = false;
  bool systemAlerts = true;
  bool emailNotifications = true;
  bool pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          title: const Text("Notification Settings"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            // ================= GENERAL =================
            _sectionTitle("General"),

            _switchTile(
              title: "Push Notifications",
              subtitle: "Receive app alerts on your device",
              value: pushNotifications,
              onChanged: (val) {
                setState(() => pushNotifications = val);
              },
            ),

            _switchTile(
              title: "Email Notifications",
              subtitle: "Receive updates via email",
              value: emailNotifications,
              onChanged: (val) {
                setState(() => emailNotifications = val);
              },
            ),

            const SizedBox(height: 20),

            // ================= LEARNING =================
            _sectionTitle("Learning"),

            _switchTile(
              title: "Course Updates",
              subtitle: "Updates about enrolled courses",
              value: courseUpdates,
              onChanged: (val) {
                setState(() => courseUpdates = val);
              },
            ),

            _switchTile(
              title: "New Lessons",
              subtitle: "When new lessons are added",
              value: newLessons,
              onChanged: (val) {
                setState(() => newLessons = val);
              },
            ),

            const SizedBox(height: 20),

            // ================= PROMOTIONS =================
            _sectionTitle("Promotions"),

            _switchTile(
              title: "Offers & Discounts",
              subtitle: "Special deals and promotions",
              value: promotions,
              onChanged: (val) {
                setState(() => promotions = val);
              },
            ),

            const SizedBox(height: 20),

            // ================= SYSTEM =================
            _sectionTitle("System"),

            _switchTile(
              title: "System Alerts",
              subtitle: "Important app updates and warnings",
              value: systemAlerts,
              onChanged: (val) {
                setState(() => systemAlerts = val);
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ================= SECTION TITLE =================
  Widget _sectionTitle(String title) {
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

  // ================= SWITCH TILE =================
  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.red200.withOpacity(0.4),
            width: 1.2,
          ),
          bottom: BorderSide(
            color: AppColors.red200.withOpacity(0.4),
            width: 1.2,
          ),
        ),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        value: value,
        activeColor: AppColors.red500,
        onChanged: onChanged,
      ),
    );
  }
}