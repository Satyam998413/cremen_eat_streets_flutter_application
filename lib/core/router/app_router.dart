import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/screens/complete_profile_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/checkout/presentation/bloc/checkout_bloc.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/orders/presentation/screens/order_tracking_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../widgets/main_shell_screen.dart';
import 'go_router_refresh_stream.dart';

/// Tab indices into [MainShellScreen] — kept in one place so a route and the
/// shell's bottom-bar selection can never drift out of sync with each other.
class ShellTab {
  static const home = 0;
  static const cart = 1;
  static const orders = 2;
  static const account = 3;
}

/// Routes with no auth-state redirect logic at all — Splash/Onboarding are
/// always shown regardless of session, Reset Password is gated by its own
/// Supabase recovery-session precondition, not this app's normal AuthBloc
/// states.
const _alwaysPublicPaths = {'/splash', '/onboarding', '/reset-password'};

/// Screens that make no sense once already logged in.
const _authOnlyPaths = {'/login', '/login/otp', '/signup', '/forgot-password'};

/// Screens that require a logged-in customer.
const _protectedPaths = {'/account'};

GoRouter buildAppRouter(AuthBloc authBloc, CheckoutBloc Function() createCheckoutBloc) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) => _redirect(authBloc.state, state),
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
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/login/otp',
        name: 'loginOtp',
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        name: 'resetPassword',
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: '/complete-profile',
        name: 'completeProfile',
        builder: (context, state) => const CompleteProfileScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const MainShellScreen(initialIndex: ShellTab.home),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const MainShellScreen(initialIndex: ShellTab.cart),
      ),
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) => BlocProvider<CheckoutBloc>(
          create: (_) => createCheckoutBloc(),
          child: const CheckoutScreen(),
        ),
      ),
      GoRoute(
        path: '/orders',
        name: 'orderHistory',
        builder: (context, state) => const MainShellScreen(initialIndex: ShellTab.orders),
      ),
      GoRoute(
        path: '/orders/:id',
        name: 'orderTracking',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          if (id == null || id.isEmpty) {
            return const _MissingOrderScreen();
          }
          return OrderTrackingScreen(orderId: id);
        },
      ),
      GoRoute(
        path: '/account',
        name: 'account',
        builder: (context, state) => const MainShellScreen(initialIndex: ShellTab.account),
      ),
    ],
  );
}

String? _redirect(AuthState authState, GoRouterState routerState) {
  final path = routerState.fullPath ?? routerState.matchedLocation;
  if (_alwaysPublicPaths.contains(path)) return null;

  if (authState is AuthNeedsProfileCompletion) {
    return path == '/complete-profile' ? null : '/complete-profile';
  }
  if (path == '/complete-profile') {
    // Nothing left to complete — don't get stuck here.
    return '/';
  }

  final isAuthenticated = authState is Authenticated;
  if (isAuthenticated) {
    return _authOnlyPaths.contains(path) ? '/' : null;
  }
  return _protectedPaths.contains(path) ? '/login' : null;
}

class _MissingOrderScreen extends StatelessWidget {
  const _MissingOrderScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Order not found.')));
  }
}
