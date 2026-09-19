// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:cremen_eatstreet_shop_application/core/di/register_module.dart'
    as _i8;
import 'package:cremen_eatstreet_shop_application/core/services/location_service.dart'
    as _i300;
import 'package:cremen_eatstreet_shop_application/core/theme/theme_cubit.dart'
    as _i1008;
import 'package:cremen_eatstreet_shop_application/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i83;
import 'package:cremen_eatstreet_shop_application/features/auth/data/repositories/auth_repository_impl.dart'
    as _i229;
import 'package:cremen_eatstreet_shop_application/features/auth/domain/repositories/auth_repository.dart'
    as _i842;
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/claim_guest_orders_usecase.dart'
    as _i611;
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/complete_profile_usecase.dart'
    as _i508;
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/login_with_password_usecase.dart'
    as _i594;
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/logout_usecase.dart'
    as _i661;
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/request_otp_usecase.dart'
    as _i107;
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/request_password_reset_usecase.dart'
    as _i34;
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/sign_in_with_google_usecase.dart'
    as _i239;
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/sign_up_with_password_usecase.dart'
    as _i878;
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/update_full_name_usecase.dart'
    as _i1071;
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/update_password_usecase.dart'
    as _i748;
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/verify_otp_usecase.dart'
    as _i899;
import 'package:cremen_eatstreet_shop_application/features/auth/presentation/bloc/auth_bloc.dart'
    as _i774;
import 'package:cremen_eatstreet_shop_application/features/b2b/data/datasources/b2b_remote_datasource.dart'
    as _i1024;
import 'package:cremen_eatstreet_shop_application/features/b2b/data/repositories/b2b_repository_impl.dart'
    as _i416;
import 'package:cremen_eatstreet_shop_application/features/b2b/domain/repositories/b2b_repository.dart'
    as _i449;
import 'package:cremen_eatstreet_shop_application/features/b2b/domain/usecases/get_assigned_wholesalers_usecase.dart'
    as _i1069;
import 'package:cremen_eatstreet_shop_application/features/b2b/domain/usecases/resolve_account_role_usecase.dart'
    as _i547;
import 'package:cremen_eatstreet_shop_application/features/b2b/presentation/bloc/sales_wholesaler_cubit.dart'
    as _i338;
import 'package:cremen_eatstreet_shop_application/features/cart/presentation/bloc/cart_bloc.dart'
    as _i304;
import 'package:cremen_eatstreet_shop_application/features/catalog/data/datasources/catalog_remote_datasource.dart'
    as _i405;
import 'package:cremen_eatstreet_shop_application/features/catalog/data/datasources/reviews_remote_datasource.dart'
    as _i933;
import 'package:cremen_eatstreet_shop_application/features/catalog/data/repositories/catalog_repository_impl.dart'
    as _i863;
import 'package:cremen_eatstreet_shop_application/features/catalog/data/repositories/reviews_repository_impl.dart'
    as _i678;
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/repositories/catalog_repository.dart'
    as _i39;
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/repositories/reviews_repository.dart'
    as _i809;
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/get_catalog_usecase.dart'
    as _i817;
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/get_eligible_review_order_usecase.dart'
    as _i809;
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/get_product_by_slug_usecase.dart'
    as _i274;
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/get_reviews_usecase.dart'
    as _i192;
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/submit_review_usecase.dart'
    as _i543;
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/bloc/catalog_bloc.dart'
    as _i59;
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/bloc/reviews_bloc.dart'
    as _i243;
import 'package:cremen_eatstreet_shop_application/features/checkout/data/datasources/checkout_remote_datasource.dart'
    as _i1038;
import 'package:cremen_eatstreet_shop_application/features/checkout/data/repositories/checkout_repository_impl.dart'
    as _i792;
import 'package:cremen_eatstreet_shop_application/features/checkout/domain/repositories/checkout_repository.dart'
    as _i163;
import 'package:cremen_eatstreet_shop_application/features/checkout/domain/usecases/create_order_usecase.dart'
    as _i531;
import 'package:cremen_eatstreet_shop_application/features/checkout/domain/usecases/reverse_geocode_usecase.dart'
    as _i19;
import 'package:cremen_eatstreet_shop_application/features/checkout/domain/usecases/verify_payment_usecase.dart'
    as _i451;
import 'package:cremen_eatstreet_shop_application/features/checkout/presentation/bloc/checkout_bloc.dart'
    as _i777;
import 'package:cremen_eatstreet_shop_application/features/orders/data/datasources/order_remote_datasource.dart'
    as _i974;
import 'package:cremen_eatstreet_shop_application/features/orders/data/repositories/order_repository_impl.dart'
    as _i373;
import 'package:cremen_eatstreet_shop_application/features/orders/domain/repositories/order_repository.dart'
    as _i1015;
import 'package:cremen_eatstreet_shop_application/features/orders/domain/usecases/get_order_by_public_token_usecase.dart'
    as _i538;
import 'package:cremen_eatstreet_shop_application/features/orders/domain/usecases/get_order_history_usecase.dart'
    as _i179;
import 'package:cremen_eatstreet_shop_application/features/orders/presentation/bloc/order_bloc.dart'
    as _i894;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i300.LocationService>(
      () => const _i300.LocationService(),
    );
    gh.lazySingleton<_i1008.ThemeCubit>(() => _i1008.ThemeCubit());
    gh.lazySingleton<_i304.CartBloc>(() => _i304.CartBloc());
    gh.lazySingleton<_i1038.CheckoutRemoteDataSource>(
      () => _i1038.CheckoutRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i83.AuthRemoteDataSource>(
      () => _i83.AuthRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i1024.B2bRemoteDataSource>(
      () => _i1024.B2bRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i405.CatalogRemoteDataSource>(
      () => _i405.CatalogRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i933.ReviewsRemoteDataSource>(
      () => _i933.ReviewsRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i974.OrderRemoteDataSource>(
      () => _i974.OrderRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i39.CatalogRepository>(
      () => _i863.CatalogRepositoryImpl(gh<_i405.CatalogRemoteDataSource>()),
    );
    gh.lazySingleton<_i163.CheckoutRepository>(
      () => _i792.CheckoutRepositoryImpl(gh<_i1038.CheckoutRemoteDataSource>()),
    );
    gh.lazySingleton<_i817.GetCatalogUseCase>(
      () => _i817.GetCatalogUseCase(gh<_i39.CatalogRepository>()),
    );
    gh.lazySingleton<_i274.GetProductBySlugUseCase>(
      () => _i274.GetProductBySlugUseCase(gh<_i39.CatalogRepository>()),
    );
    gh.lazySingleton<_i531.CreateOrderUseCase>(
      () => _i531.CreateOrderUseCase(gh<_i163.CheckoutRepository>()),
    );
    gh.lazySingleton<_i19.ReverseGeocodeUseCase>(
      () => _i19.ReverseGeocodeUseCase(gh<_i163.CheckoutRepository>()),
    );
    gh.lazySingleton<_i451.VerifyPaymentUseCase>(
      () => _i451.VerifyPaymentUseCase(gh<_i163.CheckoutRepository>()),
    );
    gh.lazySingleton<_i809.ReviewsRepository>(
      () => _i678.ReviewsRepositoryImpl(gh<_i933.ReviewsRemoteDataSource>()),
    );
    gh.lazySingleton<_i842.AuthRepository>(
      () => _i229.AuthRepositoryImpl(gh<_i83.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i59.CatalogBloc>(
      () => _i59.CatalogBloc(gh<_i817.GetCatalogUseCase>()),
    );
    gh.factory<_i777.CheckoutBloc>(
      () => _i777.CheckoutBloc(
        createOrder: gh<_i531.CreateOrderUseCase>(),
        verifyPayment: gh<_i451.VerifyPaymentUseCase>(),
      ),
    );
    gh.lazySingleton<_i449.B2bRepository>(
      () => _i416.B2bRepositoryImpl(gh<_i1024.B2bRemoteDataSource>()),
    );
    gh.lazySingleton<_i1015.OrderRepository>(
      () => _i373.OrderRepositoryImpl(gh<_i974.OrderRemoteDataSource>()),
    );
    gh.lazySingleton<_i809.GetEligibleReviewOrderUseCase>(
      () => _i809.GetEligibleReviewOrderUseCase(gh<_i809.ReviewsRepository>()),
    );
    gh.lazySingleton<_i192.GetReviewsUseCase>(
      () => _i192.GetReviewsUseCase(gh<_i809.ReviewsRepository>()),
    );
    gh.lazySingleton<_i543.SubmitReviewUseCase>(
      () => _i543.SubmitReviewUseCase(gh<_i809.ReviewsRepository>()),
    );
    gh.factory<_i243.ReviewsBloc>(
      () => _i243.ReviewsBloc(
        getReviews: gh<_i192.GetReviewsUseCase>(),
        getEligibleReviewOrder: gh<_i809.GetEligibleReviewOrderUseCase>(),
        submitReview: gh<_i543.SubmitReviewUseCase>(),
      ),
    );
    gh.lazySingleton<_i1069.GetAssignedWholesalersUseCase>(
      () => _i1069.GetAssignedWholesalersUseCase(gh<_i449.B2bRepository>()),
    );
    gh.lazySingleton<_i547.ResolveAccountRoleUseCase>(
      () => _i547.ResolveAccountRoleUseCase(gh<_i449.B2bRepository>()),
    );
    gh.lazySingleton<_i611.ClaimGuestOrdersUseCase>(
      () => _i611.ClaimGuestOrdersUseCase(gh<_i842.AuthRepository>()),
    );
    gh.lazySingleton<_i508.CompleteProfileUseCase>(
      () => _i508.CompleteProfileUseCase(gh<_i842.AuthRepository>()),
    );
    gh.lazySingleton<_i594.LoginWithPasswordUseCase>(
      () => _i594.LoginWithPasswordUseCase(gh<_i842.AuthRepository>()),
    );
    gh.lazySingleton<_i661.LogoutUseCase>(
      () => _i661.LogoutUseCase(gh<_i842.AuthRepository>()),
    );
    gh.lazySingleton<_i107.RequestOtpUseCase>(
      () => _i107.RequestOtpUseCase(gh<_i842.AuthRepository>()),
    );
    gh.lazySingleton<_i34.RequestPasswordResetUseCase>(
      () => _i34.RequestPasswordResetUseCase(gh<_i842.AuthRepository>()),
    );
    gh.lazySingleton<_i239.SignInWithGoogleUseCase>(
      () => _i239.SignInWithGoogleUseCase(gh<_i842.AuthRepository>()),
    );
    gh.lazySingleton<_i878.SignUpWithPasswordUseCase>(
      () => _i878.SignUpWithPasswordUseCase(gh<_i842.AuthRepository>()),
    );
    gh.lazySingleton<_i1071.UpdateFullNameUseCase>(
      () => _i1071.UpdateFullNameUseCase(gh<_i842.AuthRepository>()),
    );
    gh.lazySingleton<_i748.UpdatePasswordUseCase>(
      () => _i748.UpdatePasswordUseCase(gh<_i842.AuthRepository>()),
    );
    gh.lazySingleton<_i899.VerifyOtpUseCase>(
      () => _i899.VerifyOtpUseCase(gh<_i842.AuthRepository>()),
    );
    gh.lazySingleton<_i338.SalesWholesalerCubit>(
      () => _i338.SalesWholesalerCubit(
        gh<_i1069.GetAssignedWholesalersUseCase>(),
      ),
    );
    gh.lazySingleton<_i538.GetOrderByPublicTokenUseCase>(
      () => _i538.GetOrderByPublicTokenUseCase(gh<_i1015.OrderRepository>()),
    );
    gh.lazySingleton<_i179.GetOrderHistoryUseCase>(
      () => _i179.GetOrderHistoryUseCase(gh<_i1015.OrderRepository>()),
    );
    gh.lazySingleton<_i774.AuthBloc>(
      () => _i774.AuthBloc(
        repository: gh<_i842.AuthRepository>(),
        loginWithPassword: gh<_i594.LoginWithPasswordUseCase>(),
        signUpWithPassword: gh<_i878.SignUpWithPasswordUseCase>(),
        requestOtp: gh<_i107.RequestOtpUseCase>(),
        verifyOtp: gh<_i899.VerifyOtpUseCase>(),
        signInWithGoogle: gh<_i239.SignInWithGoogleUseCase>(),
        requestPasswordReset: gh<_i34.RequestPasswordResetUseCase>(),
        updatePassword: gh<_i748.UpdatePasswordUseCase>(),
        completeProfile: gh<_i508.CompleteProfileUseCase>(),
        updateFullName: gh<_i1071.UpdateFullNameUseCase>(),
        claimGuestOrders: gh<_i611.ClaimGuestOrdersUseCase>(),
        logout: gh<_i661.LogoutUseCase>(),
        resolveAccountRole: gh<_i547.ResolveAccountRoleUseCase>(),
      ),
    );
    gh.lazySingleton<_i894.OrderBloc>(
      () => _i894.OrderBloc(
        getOrderHistory: gh<_i179.GetOrderHistoryUseCase>(),
        getOrderByPublicToken: gh<_i538.GetOrderByPublicTokenUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i8.RegisterModule {}
