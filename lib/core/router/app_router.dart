import 'package:go_router/go_router.dart';

import '../../features/splash/splash_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/splash/welcome_page_1.dart';
import '../../features/splash/welcome_page_2.dart';
import '../../features/splash/welcome_page_3.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';

import '/features/initials/interest_picker.dart';
import '/features/initials/avatar_picker.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [

      /// SPLASH + WELCOME
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
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

      /// AUTH
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      /// REGISTER + ONBOARDING CHILD ROUTES
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

      /// HOME
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}