import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'core/services/hive_storage_service.dart';
import 'core/theme/app_theme.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/catalog/presentation/bloc/catalog_bloc.dart';
import 'features/orders/presentation/bloc/order_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorageService.init();
  runApp(const CremenEatStreetApp());
}

class CremenEatStreetApp extends StatelessWidget {
  const CremenEatStreetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CatalogBloc>(
          create: (_) => CatalogBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc(),
        ),
        BlocProvider<OrderBloc>(
          create: (_) => OrderBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Cremen Eat Streets',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
      ),
    );
  }
}
