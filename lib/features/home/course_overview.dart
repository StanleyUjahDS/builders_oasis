import 'package:flutter/material.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';


class CourseOverviewScreen extends StatefulWidget {
  final String courseId;

  const CourseOverviewScreen({
    super.key,
    required this.courseId,
  });

  @override
  State<CourseOverviewScreen> createState() =>
      _CourseOverviewScreenState();
}

class _CourseOverviewScreenState extends State<CourseOverviewScreen> {
  String selectedTab = "About";

  final List<String> tabs = [
    "About",
    "Payment",
    "Content",
  ];

  final List<Map<String, dynamic>> allCourses = [
    {
      "id": "course_001",
      "title": "Flutter Development Bootcamp",
      "category": "Mobile",
      "instructor": "Angela Yu",
      "image": "assets/avatars/thumb_nail_one.png",
      "durationHours": 18,
      "price": 19.99,
      "rating": 4.8,
      "isPopular": true,
    },

    {
      "id": "course_002",
      "title": "Machine Learning Fundamentals",
      "category": "AI",
      "instructor": "Andrew Ng",
      "image": "assets/avatars/thumb_nail_two.png",
      "durationHours": 24,
      "price": 29.99,
      "rating": 4.9,
      "isPopular": true,
    },

    {
      "id": "course_003",
      "title": "UI/UX Design Essentials",
      "category": "Design",
      "instructor": "Sarah Lee",
      "image": "assets/avatars/thumb_nail_three.png",
      "durationHours": 12,
      "price": 14.99,
      "rating": 4.7,
      "isPopular": false,
    },

    {
      "id": "course_004",
      "title": "Python for Data Science",
      "category": "Data",
      "instructor": "Jose Portilla",
      "image": "assets/avatars/thumb_nail_four.png",
      "durationHours": 30,
      "price": 24.99,
      "rating": 4.9,
      "isPopular": true,
    },

    {
      "id": "course_005",
      "title": "Cybersecurity Basics",
      "category": "Security",
      "instructor": "David Kim",
      "image": "assets/avatars/thumb_nail_five.png",
      "durationHours": 15,
      "price": 17.99,
      "rating": 4.6,
      "isPopular": false,
    },

    {
      "id": "course_006",
      "title": "Advanced Networking",
      "category": "Network",
      "instructor": "Stanley Tech",
      "image": "assets/avatars/thunmb_nail_six.png",
      "durationHours": 20,
      "price": 21.99,
      "rating": 4.5,
      "isPopular": false,
    },

    {
      "id": "course_007",
      "title": "React Native Essentials",
      "category": "Mobile",
      "instructor": "Maximilian",
      "image": "assets/avatars/thumb_nail_one.png",
      "durationHours": 16,
      "price": 18.99,
      "rating": 4.6,
      "isPopular": true,
    },

    {
      "id": "course_008",
      "title": "Figma UI Masterclass",
      "category": "Design",
      "instructor": "Emily Carter",
      "image": "assets/avatars/thumb_nail_three.png",
      "durationHours": 10,
      "price": 12.99,
      "rating": 4.8,
      "isPopular": true,
    },

    {
      "id": "course_009",
      "title": "Deep Learning with TensorFlow",
      "category": "AI",
      "instructor": "Sebastian Raschka",
      "image": "assets/avatars/thumb_nail_two.png",
      "durationHours": 35,
      "price": 34.99,
      "rating": 4.9,
      "isPopular": true,
    },

    {
      "id": "course_010",
      "title": "Ethical Hacking Bootcamp",
      "category": "Security",
      "instructor": "Kevin Mitnick",
      "image": "assets/avatars/thumb_nail_five.png",
      "durationHours": 22,
      "price": 27.99,
      "rating": 4.7,
      "isPopular": true,
    },

    {
      "id": "course_011",
      "title": "SQL & Database Design",
      "category": "Data",
      "instructor": "Mosh Hamedani",
      "image": "assets/avatars/thumb_nail_four.png",
      "durationHours": 14,
      "price": 16.99,
      "rating": 4.5,
      "isPopular": false,
    },

    {
      "id": "course_012",
      "title": "Cisco Networking Basics",
      "category": "Network",
      "instructor": "James Peterson",
      "image": "assets/avatars/thunmb_nail_six.png",
      "durationHours": 18,
      "price": 20.99,
      "rating": 4.4,
      "isPopular": false,
    },

    {
      "id": "course_013",
      "title": "Kotlin Android Development",
      "category": "Mobile",
      "instructor": "Google Dev Team",
      "image": "assets/avatars/thumb_nail_one.png",
      "durationHours": 19,
      "price": 22.99,
      "rating": 4.8,
      "isPopular": true,
    },

    {
      "id": "course_014",
      "title": "Adobe XD Complete Guide",
      "category": "Design",
      "instructor": "Linda James",
      "image": "assets/avatars/thumb_nail_three.png",
      "durationHours": 11,
      "price": 13.99,
      "rating": 4.5,
      "isPopular": false,
    },

    {
      "id": "course_015",
      "title": "AI Prompt Engineering",
      "category": "AI",
      "instructor": "OpenAI Labs",
      "image": "assets/avatars/thumb_nail_two.png",
      "durationHours": 8,
      "price": 15.99,
      "rating": 4.9,
      "isPopular": true,
    },
{
"id": "course_intro_bonus",
"title": "Intro Bonus: Start Your Tech Journey",
"category": "Beginner",
"instructor": "Builders Oasis Team",
"image": "assets/avatars/thumb_nail_one.png",
"durationHours": 5,
"price": 0.0,
"rating": 5.0,
"isFree": true,
}
  ];

  @override
  Widget build(BuildContext context) {
    final course = allCourses.firstWhere(
          (c) => c['id'] == widget.courseId,
      orElse: () => {},
    );

    if (course.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Course not found")),
      );
    }

    return GradientScaffold(
      child: Scaffold(
        appBar: AppBar(
          title: Text(course['title']),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              // ================= IMAGE =================
              Image.asset(
                course['image'],
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
      
              const SizedBox(height: 16),
      
              // ================= INFO =================
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
      
                    Text(
                      course['title'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
      
                    const SizedBox(height: 6),
      
                    Text("Instructor: ${course['instructor']}"),
                    Text("Category: ${course['category']}"),
                    Text("Duration: ${course['durationHours']}h"),
      
                    const SizedBox(height: 10),
      
                    Text(
                      course['price'] == 0
                          ? "FREE COURSE"
                          : "\$${course['price']}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: course['price'] == 0
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),
      
                    const SizedBox(height: 20),
      
                    // ================= BUTTON =================
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          course['price'] == 0
                              ? "Start Free Course"
                              : "Enroll Now",
                        ),
                      ),
                    ),
      
                    const SizedBox(height: 20),
      
                    // ================= TABS =================
                    SizedBox(
                      height: 45,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: tabs.length,
                        separatorBuilder: (_, __) =>
                        const SizedBox(width: 10),
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
                                    ? Colors.redAccent
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.redAccent.withOpacity(0.4),
                                    width: 1.5,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.redAccent.withOpacity(0.4),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              child: Text(
                                tab,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : null,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
      
                    const SizedBox(height: 20),
      
                    // ================= TAB CONTENT =================
                    _buildTabContent(course),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= IMPROVED TAB CONTENT =================
  Widget _buildTabContent(Map<String, dynamic> course) {
    switch (selectedTab) {

    // ================= ABOUT =================
      case "About":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "About this course",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "This course is designed to take you from beginner to confident developer. "
                  "You will build real projects, understand core concepts, and gain practical experience.",
              style: TextStyle(
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ],
        );

    // ================= PAYMENT =================
      case "Payment":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment Overview",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Course Price"),
                  Text(
                    course['price'] == 0
                        ? "FREE"
                        : "\$${course['price']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Text(
              course['price'] == 0
                  ? "No payment required. You can start immediately."
                  : "Secure payment required to unlock full access.",
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        );

    // ================= CONTENT =================
      case "Content":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Course Content",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),

            Text("1. Introduction to the course"),
            SizedBox(height: 6),
            Text("2. Core fundamentals"),
            SizedBox(height: 6),
            Text("3. Hands-on projects"),
            SizedBox(height: 6),
            Text("4. Real-world applications"),
            SizedBox(height: 6),
            Text("5. Final assessment"),
          ],
        );

      default:
        return const SizedBox();
    }
  }
}