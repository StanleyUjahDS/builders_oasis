import 'package:flutter/material.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';
import '/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:builders_oasis/widgets/cards/course_card.dart';
import 'package:builders_oasis/widgets/cards/CourseCompactCard.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import '/features/auth/providers/auth_provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
final Map<String, dynamic> introBonusCourse = {
  "id": "course_intro_bonus",
  "title": "Intro Bonus: Start Your Tech Journey",
  "category": "Beginner",
  "instructor": "Builders Oasis Team",
  "image": "assets/avatars/thumb_nail_one.png",
  "durationHours": 5,
  "price": 0.0,
  "rating": 5.0,
  "isFree": true,
};

String selectedCategory = "All";

final List<String> categories = [
  "All",
  "Mobile",
  "AI",
  "Design",
  "Data",
  "Security",
  "Network",
];

List<Map<String, dynamic>> get filteredCourses {
  if (selectedCategory == "All") {
    return courses;
  }

  return courses.where((course) {
    return course['category'] == selectedCategory;
  }).toList();
}
final List<Map<String, dynamic>> courses = [
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
];
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider =
    context.watch<UserProvider>();
    final user = userProvider.user;
    return  GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,

            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [

                    //  Profile + Name (LEFT SIDE)
                    Row(
                      children: [
                        InkWell(
                          onTap: () => context.push("/profile"),
                          borderRadius: BorderRadius.circular(30),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                            user?.profileImage != null
                                ? NetworkImage(user!.profileImage!)
                                : const AssetImage(
                              "assets/icons/H_badger_icon.png",
                            ) as ImageProvider,                          ),
                        ),
                        const SizedBox(width: 8),
                         Text(
                            user?.firstName ?? 'Guest',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),

                    const Spacer(),

                    //  Notifications
                    IconButton(
                      onPressed: () {context.push('/notification_fields');},
                      icon: const Icon(Icons.notifications_none),
                    ),

                    // 🛒 Cart
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_cart_outlined),
                    ),

                    // ⋮ Menu
                    PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.more_horiz),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onSelected: (value) {
                        if (value == 'settings') {
                          // navigate
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'settings',
                          child: Text('Settings'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        body: CustomScrollView(
          slivers: [

            /* ---------------- TITLE ---------------- */
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'What would you like to learn today?',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            /* ---------------- SEARCH BAR ---------------- */
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.push('/search'),
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border: Border(
                          top: BorderSide(
                            color: AppColors.red200.withValues(alpha: 0.6),
                            width: 1.5,
                          ),
                          bottom: BorderSide(
                            color: AppColors.red200.withValues(alpha: 0.6),
                            width: 1.5,
                          ),
                          left: BorderSide.none,
                          right: BorderSide.none,
                      ),),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 10),
                          Text("Search courses, topics..."),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            /* ---------------- INTRO BONUS ---------------- */
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Intro Bonus Course",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CourseDetailCard(
                  title: introBonusCourse['title'],
                  category: introBonusCourse['category'],
                  instructor: introBonusCourse['instructor'],
                  image: introBonusCourse['image'],
                  durationHours: introBonusCourse['durationHours'],
                  price: introBonusCourse['price'],
                  onTap: () {
                    context.push("/course_overview/${introBonusCourse['id']}");
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            /* ---------------- POPULAR TITLE ---------------- */
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Popular Courses",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            /* ---------------- HORIZONTAL POPULAR ---------------- */
            SliverToBoxAdapter(
              child: SizedBox(
                height: 265,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: courses.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final course = courses[index];

                    return CourseCard(
                      title: course['title'],
                      category: course['category'],
                      instructor: course['instructor'],
                      image: course['image'],
                      durationHours: course['durationHours'],
                      price: course['price'],
                      onTap: () {
                        context.push("/course_overview/${course['id']}");
                      },
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            /* ---------------- FILTER TITLE ---------------- */
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Browse Categories",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            /* ---------------- STICKY FILTER ROW ---------------- */
            SliverPersistentHeader(
              pinned: true,
              delegate: _CategoryHeader(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.05),
                        Colors.black.withValues(alpha: 0.15),
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final isSelected = selectedCategory == category;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
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
                                    color: AppColors.red200.withValues(alpha: 0.6),
                                    width: 1.5,
                                  ),
                                  bottom: BorderSide(
                                    color: AppColors.red200.withValues(alpha: 0.6),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /* ---------------- FILTERED COURSES ---------------- */
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final course = filteredCourses[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: CourseDetailCard(
                      title: course['title'],
                      category: course['category'],
                      instructor: course['instructor'],
                      image: course['image'],
                      durationHours: course['durationHours'],
                      price: course['price'],
                      onTap: () {
                        context.push("/course_overview/${course['id']}");

                      },
                    ),
                  );
                },
                childCount: filteredCourses.length,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 200)),
          ],
        ),
      ),
    );
  }
}
class _CategoryHeader extends SliverPersistentHeaderDelegate {
  final Widget child;

  _CategoryHeader({required this.child});

  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 50;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Material(
      color: Colors.transparent,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _CategoryHeader oldDelegate) {
    return oldDelegate.child != child;
  }
}