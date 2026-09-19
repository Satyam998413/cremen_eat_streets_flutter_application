import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/domain/entities/account_role.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/screens/complete_profile_screen.dart';
import '../../features/b2b/presentation/screens/b2b_shell_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/catalog/presentation/screens/product_by_slug_screen.dart';
import '../../features/checkout/presentation/bloc/checkout_bloc.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/orders/presentation/screens/order_tracking_screen.dart';
import '../../features/profile/presentation/screens/returns_policy_screen.dart';
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

/// Screens that require a logged-in account. Unlike the retail catalog/cart/
/// checkout paths (which deliberately support guest checkout), the B2B home
/// has no guest concept at all — a salesman/wholesaler role can only ever
/// come from a real session, so an unauthenticated visitor is sent to
/// /login rather than seeing an unbranded, effectively-retail-priced
/// "Wholesale Ordering" screen.
const _protectedPaths = {'/account', '/b2b'};

/// Wraps a route's screen in a Material "fade through" transition (the
/// recommended motion for navigating between unrelated destinations) instead
/// of go_router's default platform page transition, for a consistent
/// branded push/pop feel on the routes below that aren't tab switches.
CustomTransitionPage<void> _fadeThroughPage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );
    },
  );
}

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
        pageBuilder: (context, state) => _fadeThroughPage(state, const CompleteProfileScreen()),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const MainShellScreen(initialIndex: ShellTab.home),
      ),
      GoRoute(
        path: '/b2b',
        name: 'b2bHome',
        builder: (context, state) => const B2bShellScreen(),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const MainShellScreen(initialIndex: ShellTab.cart),
      ),
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        pageBuilder: (context, state) => _fadeThroughPage(
          state,
          BlocProvider<CheckoutBloc>(
            create: (_) => createCheckoutBloc(),
            child: const CheckoutScreen(),
          ),
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
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'];
          final child = (id == null || id.isEmpty)
              ? const _MissingRouteParamScreen('Order not found.')
              : OrderTrackingScreen(orderId: id);
          return _fadeThroughPage(state, child);
        },
      ),
      GoRoute(
        path: '/account',
        name: 'account',
        builder: (context, state) => const MainShellScreen(initialIndex: ShellTab.account),
      ),
      GoRoute(
        path: '/account/returns-policy',
        name: 'returnsPolicy',
        pageBuilder: (context, state) => _fadeThroughPage(state, const ReturnsPolicyScreen()),
      ),
      // Deep-link entry points — the website's own public URL shapes
      // (`/shop/:slug`, `/order/:publicToken`), reachable via the app's
      // registered custom scheme and (once assetlinks/AASA are published)
      // Android App Links / iOS Universal Links.
      GoRoute(
        path: '/shop/:slug',
        name: 'productBySlug',
        pageBuilder: (context, state) {
          final slug = state.pathParameters['slug'];
          final child = (slug == null || slug.isEmpty)
              ? const _MissingRouteParamScreen('Product not found.')
              : ProductBySlugScreen(slug: slug);
          return _fadeThroughPage(state, child);
        },
      ),
      GoRoute(
        path: '/order/:publicToken',
        name: 'orderReceipt',
        redirect: (context, state) => '/orders/${state.pathParameters['publicToken']}',
      ),
    ],
  );
}

/// The "home" a signed-in account lands on right after login/session-restore,
/// and the destination any of [_authOnlyPaths] should bounce to — a
/// salesman/wholesaler account never sees the retail customer shell's Home
/// tab (`/`), and vice versa.
String _homePathFor(AccountRole role) => role == AccountRole.customer ? '/' : '/b2b';

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

  if (authState is Authenticated) {
    final home = _homePathFor(authState.role);
    if (_authOnlyPaths.contains(path)) return home;
    // Cart/checkout/orders/account are shared between retail and B2B — only
    // the "/" vs "/b2b" catalog entry point differs per role.
    if (authState.role == AccountRole.customer && path == '/b2b') return '/';
    if (authState.role != AccountRole.customer && path == '/') return '/b2b';
    return null;
  }
  return _protectedPaths.contains(path) ? '/login' : null;
}

class _MissingRouteParamScreen extends StatelessWidget {
  const _MissingRouteParamScreen(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(message)));
  }
}
