import 'package:flutter/material.dart';

import '/core/ui/scaffolds/gradient_scaffold.dart';
import '/core/theme/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String selectedTab = "All";

  final List<String> tabs = [
    "All",
    "Courses",
    "System",
  ];

  final List<Map<String, dynamic>> notifications = [
    {
      "title": "New Course Available",
      "message": "Flutter Advanced course is now live",
      "type": "Courses",
      "isRead": false,
      "time": "2h ago",
    },
    {
      "title": "Payment Successful",
      "message": "Your course purchase was successful",
      "type": "System",
      "isRead": true,
      "time": "1d ago",
    },
    {
      "title": "New Lesson Added",
      "message": "AI Prompt Engineering updated",
      "type": "Courses",
      "isRead": false,
      "time": "3d ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          title: const Text("Notifications"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: Column(
          children: [

            const SizedBox(height: 10),

            // ================= TABS =================
            SizedBox(
              height: 45,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final tab = tabs[index];
                  final isSelected = selectedTab == tab;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = tab;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.red500
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border(
                          top: BorderSide(
                            color: AppColors.red200.withOpacity(0.5),
                            width: 1.5,
                          ),
                          bottom: BorderSide(
                            color: AppColors.red200.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(
                        tab,
                        style: TextStyle(
                          color: isSelected ? Colors.white : null,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // ================= LIST =================
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: _filteredNotifications().length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = _filteredNotifications()[index];

                  return _notificationTile(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= FILTER =================
  List<Map<String, dynamic>> _filteredNotifications() {
    if (selectedTab == "All") return notifications;

    return notifications
        .where((n) => n['type'] == selectedTab)
        .toList();
  }

  // ================= TILE =================
  Widget _notificationTile(Map<String, dynamic> item) {
    final isRead = item['isRead'];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border(
          top: BorderSide(
            color: AppColors.red200.withOpacity(0.4),
          ),
          bottom: BorderSide(
            color: AppColors.red200.withOpacity(0.4),
          ),
        ),
        color: isRead ? Colors.transparent : Colors.red.withOpacity(0.05),
      ),
      child: Row(
        children: [

          // ICON DOT
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isRead ? Colors.grey : Colors.red,
            ),
          ),

          const SizedBox(width: 12),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  item['message'],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Text(
            item['time'],
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}