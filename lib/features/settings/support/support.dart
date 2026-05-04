import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/theme/app_colors.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        // ================= APP BAR =================
        appBar: AppBar(
          title: const Text(
            "Help & Support",
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

            const Text(
              "We’re here to help you",
              style: TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 20),

            // ================= FAQ =================
            _tile(
              context,
              icon: Icons.help_outline,
              title: "FAQs",
              subtitle: "Find answers to common questions",
              onTap: () {
                context.push("/faq");
              },
            ),

            // ================= CONTACT SUPPORT =================
            _tile(
              context,
              icon: Icons.support_agent,
              title: "Contact Support",
              subtitle: "Chat or email our support team",
              onTap: () {
                context.push("/contact_support");
              },
            ),

            // ================= REPORT ISSUE =================
            _tile(
              context,
              icon: Icons.bug_report_outlined,
              title: "Report a Problem",
              subtitle: "Let us know if something is broken",
              onTap: () {
                context.push("/report_issue");
              },
            ),

            // ================= TERMS =================
            _tile(
              context,
              icon: Icons.description_outlined,
              title: "Terms & Privacy",
              subtitle: "Read our policies",
              onTap: () {
                context.push("/terms");
              },
            ),

            const SizedBox(height: 30),

            // ================= FOOTER =================
            Center(
              child: Text(
                "Builders Oasis • Support",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= TILE WIDGET =================
  Widget _tile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
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
        leading: Icon(icon, color: Colors.red),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}