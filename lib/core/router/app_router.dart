import 'package:go_router/go_router.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/splash/welcome_page_1.dart';
import '../../features/splash/welcome_page_2.dart';
import '../../features/splash/welcome_page_3.dart';



class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
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
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
    ],
  );
}