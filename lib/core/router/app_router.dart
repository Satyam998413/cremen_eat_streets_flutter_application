import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/orders/presentation/screens/order_tracking_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../widgets/main_shell_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const MainShellScreen(initialIndex: 0),
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => const MainShellScreen(initialIndex: 1),
    ),
    GoRoute(
      path: '/orders',
      name: 'orderHistory',
      builder: (context, state) => const MainShellScreen(initialIndex: 2),
    ),
    GoRoute(
      path: '/orders/:id',
      name: 'orderTracking',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'ORD-001';
        return OrderTrackingScreen(orderId: id);
      },
    ),
    GoRoute(
      path: '/admin/dashboard',
      name: 'adminDashboard',
      builder: (context, state) => const MainShellScreen(initialIndex: 3),
    ),
  ],
);
