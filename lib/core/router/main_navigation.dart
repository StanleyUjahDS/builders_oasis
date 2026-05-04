import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '/features/home/home_screen.dart';
import '/features/learning/learning_screen.dart';
import '/features/reminder/reminder_screen.dart';
import '/features/settings/settings_screen.dart';
import '/core/theme/app_colors.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      const HomeScreen(),
      const LearningScreen(),
      const ReminderScreen(),
      const SettingsScreen(),
    ];
  }

  Widget _icon(IconData icon, bool active) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.red : Colors.transparent,
        border: Border.all(
          color: active ? Colors.white : Colors.black,
          width: 1.2,
        ),
      ),
      child: Icon(
        icon,
        size: 23,
        color: active ? Colors.white : Colors.black87,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 22),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),

          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 25,
              sigmaY: 25,
            ),

            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(60),

                border: Border(
                  top: BorderSide(
                    color: AppColors.red200.withValues(alpha: 0.6),
                    width: 1.5,
                  ),
                  bottom: BorderSide(
                    color: AppColors.red200.withValues(alpha: 0.6),
                    width: 1.5,
                  ),
                ),
              ),

              child: GNav(
                selectedIndex: currentIndex,

                onTabChange: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },

                gap: 2,
                iconSize: 0,
                color: Colors.black87,

                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),

                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),

                tabBackgroundColor: AppColors.red200,

                rippleColor: Colors.red.withValues(alpha: 0.12),
                hoverColor: Colors.red.withValues(alpha: 0.08),

                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: "Home",
                    leading: _icon(
                      Icons.home,
                      currentIndex == 0,
                    ),
                  ),

                  GButton(
                    icon: Icons.school,
                    text: "Learning",
                    leading: _icon(
                      Icons.school,
                      currentIndex == 1,
                    ),
                  ),

                  GButton(
                    icon: Icons.access_time,
                    text: "Reminder",
                    leading: _icon(
                      Icons.access_time,
                      currentIndex == 2,
                    ),
                  ),

                  GButton(
                    icon: Icons.settings,
                    text: "Settings",
                    leading: _icon(
                      Icons.settings,
                      currentIndex == 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}