import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/config/app_config.dart';
import 'core/network/dio_client.dart';
import 'core/router/app_router.dart';
import 'core/services/hive_storage_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/claim_guest_orders_usecase.dart';
import 'features/auth/domain/usecases/complete_profile_usecase.dart';
import 'features/auth/domain/usecases/login_with_password_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/request_otp_usecase.dart';
import 'features/auth/domain/usecases/request_password_reset_usecase.dart';
import 'features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'features/auth/domain/usecases/sign_up_with_password_usecase.dart';
import 'features/auth/domain/usecases/update_full_name_usecase.dart';
import 'features/auth/domain/usecases/update_password_usecase.dart';
import 'features/auth/domain/usecases/verify_otp_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/catalog/data/datasources/catalog_remote_datasource.dart';
import 'features/catalog/data/datasources/reviews_remote_datasource.dart';
import 'features/catalog/data/repositories/catalog_repository_impl.dart';
import 'features/catalog/data/repositories/reviews_repository_impl.dart';
import 'features/catalog/domain/repositories/reviews_repository.dart';
import 'features/catalog/domain/usecases/get_catalog_usecase.dart';
import 'features/catalog/domain/usecases/get_eligible_review_order_usecase.dart';
import 'features/catalog/domain/usecases/get_reviews_usecase.dart';
import 'features/catalog/domain/usecases/submit_review_usecase.dart';
import 'features/catalog/presentation/bloc/catalog_bloc.dart';
import 'features/checkout/data/datasources/checkout_remote_datasource.dart';
import 'features/checkout/data/repositories/checkout_repository_impl.dart';
import 'features/checkout/domain/repositories/checkout_repository.dart';
import 'features/checkout/domain/usecases/create_order_usecase.dart';
import 'features/checkout/domain/usecases/reverse_geocode_usecase.dart';
import 'features/checkout/domain/usecases/verify_payment_usecase.dart';
import 'features/checkout/presentation/bloc/checkout_bloc.dart';
import 'features/orders/data/datasources/order_remote_datasource.dart';
import 'features/orders/data/repositories/order_repository_impl.dart';
import 'features/orders/domain/usecases/get_order_by_public_token_usecase.dart';
import 'features/orders/domain/usecases/get_order_history_usecase.dart';
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
  runApp(const CremenEatStreetApp());
}

class CremenEatStreetApp extends StatefulWidget {
  const CremenEatStreetApp({super.key});

  @override
  State<CremenEatStreetApp> createState() => _CremenEatStreetAppState();
}

class _CremenEatStreetAppState extends State<CremenEatStreetApp> {
  // Built once, outside any widget rebuild — no DI container yet (tracked as
  // a follow-up per plan/user-app-production-rebuild.md Step 8), so every
  // dependency is wired by hand right here instead.
  late final AuthRepository _authRepository;
  late final AuthBloc _authBloc;
  late final GetCatalogUseCase _getCatalog;
  late final CheckoutRepository _checkoutRepository;
  late final GetOrderHistoryUseCase _getOrderHistory;
  late final GetOrderByPublicTokenUseCase _getOrderByPublicToken;
  late final GetReviewsUseCase _getReviews;
  late final GetEligibleReviewOrderUseCase _getEligibleReviewOrder;
  late final SubmitReviewUseCase _submitReview;
  late final ReverseGeocodeUseCase _reverseGeocode;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepositoryImpl(AuthRemoteDataSource(Supabase.instance.client));
    _getCatalog = GetCatalogUseCase(CatalogRepositoryImpl(CatalogRemoteDataSource(Supabase.instance.client)));
    _checkoutRepository = CheckoutRepositoryImpl(CheckoutRemoteDataSource(buildDioClient()));
    final orderRepository = OrderRepositoryImpl(OrderRemoteDataSource(Supabase.instance.client));
    _getOrderHistory = GetOrderHistoryUseCase(orderRepository);
    _getOrderByPublicToken = GetOrderByPublicTokenUseCase(orderRepository);
    final ReviewsRepository reviewsRepository =
        ReviewsRepositoryImpl(ReviewsRemoteDataSource(Supabase.instance.client));
    _getReviews = GetReviewsUseCase(reviewsRepository);
    _getEligibleReviewOrder = GetEligibleReviewOrderUseCase(reviewsRepository);
    _submitReview = SubmitReviewUseCase(reviewsRepository);
    _reverseGeocode = ReverseGeocodeUseCase(_checkoutRepository);
    _authBloc = AuthBloc(
      repository: _authRepository,
      loginWithPassword: LoginWithPasswordUseCase(_authRepository),
      signUpWithPassword: SignUpWithPasswordUseCase(_authRepository),
      requestOtp: RequestOtpUseCase(_authRepository),
      verifyOtp: VerifyOtpUseCase(_authRepository),
      signInWithGoogle: SignInWithGoogleUseCase(_authRepository),
      requestPasswordReset: RequestPasswordResetUseCase(_authRepository),
      updatePassword: UpdatePasswordUseCase(_authRepository),
      completeProfile: CompleteProfileUseCase(_authRepository),
      updateFullName: UpdateFullNameUseCase(_authRepository),
      claimGuestOrders: ClaimGuestOrdersUseCase(_authRepository),
      logout: LogoutUseCase(_authRepository),
    );
    _router = buildAppRouter(
      _authBloc,
      () => CheckoutBloc(
        createOrder: CreateOrderUseCase(_checkoutRepository),
        verifyPayment: VerifyPaymentUseCase(_checkoutRepository),
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GetReviewsUseCase>.value(value: _getReviews),
        RepositoryProvider<GetEligibleReviewOrderUseCase>.value(value: _getEligibleReviewOrder),
        RepositoryProvider<SubmitReviewUseCase>.value(value: _submitReview),
        RepositoryProvider<ReverseGeocodeUseCase>.value(value: _reverseGeocode),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CatalogBloc>(
            create: (_) => CatalogBloc(_getCatalog),
          ),
          BlocProvider<CartBloc>(
            create: (_) => CartBloc(),
          ),
          BlocProvider<OrderBloc>(
            create: (_) => OrderBloc(
              getOrderHistory: _getOrderHistory,
              getOrderByPublicToken: _getOrderByPublicToken,
            ),
          ),
          BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit(),
          ),
          BlocProvider<AuthBloc>.value(value: _authBloc),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) => MaterialApp.router(
            title: 'Cremen Eat Streets',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: _router,
          ),
        ),
      ),
    );
  }
}
