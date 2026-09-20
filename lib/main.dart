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
  await HiveStorageService.init();
  await Hive.openBox(ThemeCubit.boxName);
  await Supabase.initialize(url: AppConfig.supabaseUrl, publishableKey: AppConfig.supabaseAnonKey);
  // AdMob has no web/desktop implementation — only initialize on mobile.
  if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
    await MobileAds.instance.initialize();
  }
  // Must run after Hive/Supabase are ready — several @lazySingleton
  // constructors (ThemeCubit, the Supabase-backed datasources) touch them
  // the first time get_it resolves that type.
  configureDependencies();
  runApp(const CremenEatStreetApp());
}

class CremenEatStreetApp extends StatefulWidget {
  const CremenEatStreetApp({super.key});

  @override
  State<CremenEatStreetApp> createState() => _CremenEatStreetAppState();
}

class _CremenEatStreetAppState extends State<CremenEatStreetApp> {
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
          title: 'Cremenkart',
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
