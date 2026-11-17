import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/config/app_config.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/services/hive_storage_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/catalog/presentation/bloc/catalog_bloc.dart';
import 'features/checkout/presentation/bloc/checkout_bloc.dart';
import 'features/orders/presentation/bloc/order_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Global Flutter and platform error handlers to catch unhandled errors gracefully
  // and prevent native OS process termination (app crashes) in production
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('FlutterError: ${details.exceptionAsString()}');
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('PlatformDispatcher error: $error\n$stack');
    return true; // Marked as handled to prevent crashing the OS process
  };

  // Safe fallback error widget in release builds so unexpected widget errors
  // don't freeze or produce a blank/broken experience
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.info_outline, color: Colors.orange, size: 48),
              const SizedBox(height: 12),
              const Text(
                'Something went wrong. Please reopen the screen.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              if (kDebugMode) ...[
                const SizedBox(height: 8),
                Text(details.exceptionAsString(), style: const TextStyle(fontSize: 11, color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  };

  // Engine performance optimization: cap in-memory image cache to 50MB / 100 images
  // to maintain smooth 60/120fps scrolling and avoid memory pressure on Android
  PaintingBinding.instance.imageCache.maximumSize = 100;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 50 * 1024 * 1024;

  try {
    await HiveStorageService.init();
  } catch (e) {
    debugPrint('HiveStorageService.init failed: $e');
  }

  try {
    if (!Hive.isBoxOpen(ThemeCubit.boxName)) {
      await Hive.openBox(ThemeCubit.boxName);
    }
  } catch (e) {
    debugPrint('Hive.openBox(ThemeCubit.boxName) failed: $e');
  }

  try {
    await Supabase.initialize(url: AppConfig.supabaseUrl, publishableKey: AppConfig.supabaseAnonKey);
  } catch (e) {
    debugPrint('Supabase.initialize failed: $e');
  }

  // AdMob has no web/desktop implementation — only initialize on mobile.
  if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
    try {
      await MobileAds.instance.initialize();
      // Set G-rated content rating to comply with family-safe ad guidelines
      final requestConfiguration = RequestConfiguration(
        maxAdContentRating: MaxAdContentRating.g,
      );
      await MobileAds.instance.updateRequestConfiguration(requestConfiguration);
    } catch (e) {
      debugPrint('MobileAds.instance.initialize failed: $e');
    }
  }

  // Must run after Hive/Supabase are ready — several @lazySingleton
  // constructors (ThemeCubit, the Supabase-backed datasources) touch them
  // the first time get_it resolves that type.
  try {
    configureDependencies();
  } catch (e) {
    debugPrint('configureDependencies failed: $e');
  }

  runApp(const CremenKartApp());
}

typedef CremenEatStreetApp = CremenKartApp;

class CremenKartApp extends StatefulWidget {
  const CremenKartApp({super.key});

  @override
  State<CremenKartApp> createState() => _CremenKartAppState();
}

class _CremenKartAppState extends State<CremenKartApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = buildAppRouter(getIt<AuthBloc>(), () => getIt<CheckoutBloc>());
  }

  @override
  void dispose() {
    getIt<AuthBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CatalogBloc>.value(value: getIt<CatalogBloc>()),
        BlocProvider<CartBloc>.value(value: getIt<CartBloc>()),
        BlocProvider<OrderBloc>.value(value: getIt<OrderBloc>()),
        BlocProvider<ThemeCubit>.value(value: getIt<ThemeCubit>()),
        BlocProvider<AuthBloc>.value(value: getIt<AuthBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) => MaterialApp.router(
          title: 'CremenKart',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          routerConfig: _router,
        ),
      ),
    );
  }
}
