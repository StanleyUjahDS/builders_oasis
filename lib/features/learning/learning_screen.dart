import 'package:flutter/material.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';
import '/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

// IMPORTANT: must contain CurrentLearningCard class
import '/widgets/cards/learning_card.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  String selectedTab = "Continue";

  final List<String> tabs = [
    "Continue",
    "Overview",
    "Saved",
  ];

  final List<Map<String, dynamic>> learningCourses = [
    {
      "id": "course_001",
      "title": "Flutter Development Bootcamp",
      "instructor": "Angela Yu",
      "image": "assets/avatars/thumb_nail_one.png",
      "progress": 0.45,
      "status": "enrolled",
    },
    {
      "id": "course_002",
      "title": "Machine Learning Fundamentals",
      "instructor": "Andrew Ng",
      "image": "assets/avatars/thumb_nail_two.png",
      "progress": 1.0,
      "status": "completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // HEADER
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "My Learning",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // TABS
              SizedBox(
                height: 45,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
                              color: AppColors.red200.withOpacity(0.6),
                              width: 1.5,
                            ),
                            bottom: BorderSide(
                              color: AppColors.red200.withOpacity(0.6),
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

              const SizedBox(height: 20),

              Expanded(child: _buildContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedTab) {

    // CONTINUE
      case "Continue":
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: learningCourses.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final course = learningCourses[index];

            return CurrentLearningCard(
              title: course['title'],
              instructor: course['instructor'],
              image: course['image'],
              progress: course['progress'],
              onContinue: () {
                context.push("/course_overview/${course['id']}");
              },
            );
          },
        );

    // OVERVIEW
      case "Overview":
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Text("Your learning progress overview will appear here."),
        );

    // SAVED
      case "Saved":
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Text("No saved courses yet."),
        );

      default:
        return const SizedBox();
    }
  }
}