import 'package:go_router/go_router.dart';

import '../../features/splash/splash_screen.dart';
import '../../features/splash/welcome_page_1.dart';
import '../../features/splash/welcome_page_2.dart';
import '../../features/splash/welcome_page_3.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';

import '/features/initials/interest_picker.dart';
import '/features/initials/avatar_picker.dart';
import '/core/router/main_navigation.dart';
import '/features/home/search_screen.dart';

import '/features/home/course_overview.dart';
import '/features/settings/profile/profile.dart';
import '/features/settings/security/security.dart';
import '/features/settings/theme/theme_settings.dart';
import '/features/settings/notification/notification.dart';
import '/features/settings/support/support.dart';
import '/features/home/notification_fields.dart';
import '/features/reminder/create_reminder.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',

    routes: [

      // SPLASH
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // WELCOME
      GoRoute(
        path: '/welcome_one',
        builder: (context, state) => const WelcomePage1(),
      ),

      GoRoute(
        path: '/welcome_two',
        builder: (context, state) => const WelcomePage2(),
      ),

      GoRoute(
        path: '/welcome_three',
        builder: (context, state) => const WelcomePage3(),
      ),

      // MAIN APP
      GoRoute(
        path: '/',
        builder: (context, state) => const MainNavigation(),
      ),

      // AUTH
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
        routes: [

          GoRoute(
            path: 'interests',
            builder: (context, state) =>
            const InterestPickerScreen(),
          ),

          GoRoute(
            path: 'avatar',
            builder: (context, state) =>
            const AvatarPickerScreen(),
          ),
        ],
      ),

      // SEARCH
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/notification_fields',
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: '/course_overview/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CourseOverviewScreen(courseId: id);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      GoRoute(
        path: '/security',
        builder: (context, state) => const SecurityScreen(),
      ),

      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationSettingsScreen(),
      ),


      GoRoute(
        path: '/theme',
        builder: (context, state) {
          return const ThemeSettingsPage();
        },
      ),
      GoRoute(
        path: '/support',
        builder: (context, state) => const SupportScreen(),
      ),
      GoRoute(
        path: '/create_reminder',
        builder: (context, state) => const CreateReminderScreen(),
      ),
    ],
  );
}