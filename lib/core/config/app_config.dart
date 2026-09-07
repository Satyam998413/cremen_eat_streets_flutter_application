/// Central place for the handful of values this app needs to talk to the
/// same backend as the Cremen Eat Streets website (`cremen_eat_streets`).
///
/// Every value here is a *public* key (Supabase's publishable/anon key model,
/// and Razorpay's `rzp_test_...` key id) — none of these grant write access on
/// their own; Postgres RLS and Razorpay's server-side secret do that. That's
/// why a real default is safe to compile in here, unlike an actual secret.
/// Override any of them at build/run time with `--dart-define=NAME=value`
/// (e.g. to point a staging build at a different Supabase project).
class AppConfig {
  const AppConfig._();

  static const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://xatewivvfedmugurixwh.supabase.co',
  );

  static const supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'sb_publishable_iYyzQLtVJeKYbM0db51rmw_7QgAIlHL',
  );

  static const razorpayKeyId = String.fromEnvironment(
    'RAZORPAY_KEY_ID',
    defaultValue: 'rzp_test_TYPfKKhlOZTsCk',
  );

  /// The website's deployed origin — hosts the 3 custom API routes this app
  /// calls directly (create-order, verify, geocode/reverse). Point this at a
  /// local dev server with --dart-define=API_BASE_URL=http://10.0.2.2:3000
  /// (Android emulator's alias for the host machine) while developing.
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://cremeneatstreet.shop',
  );

  /// AdMob banner ad unit IDs. These default to Google's public *test* units,
  /// which always serve a "Test Ad" placeholder and are safe to ship in debug
  /// builds. Override both with your real AdMob console IDs at release-build
  /// time via --dart-define, e.g.
  /// --dart-define=ADMOB_BANNER_AD_UNIT_ID_ANDROID=ca-app-pub-xxxx/yyyy
  static const admobBannerAdUnitIdAndroid = String.fromEnvironment(
    'ADMOB_BANNER_AD_UNIT_ID_ANDROID',
    defaultValue: 'ca-app-pub-3940256099942544/6300978111',
  );

  static const admobBannerAdUnitIdIOS = String.fromEnvironment(
    'ADMOB_BANNER_AD_UNIT_ID_IOS',
    defaultValue: 'ca-app-pub-3940256099942544/2934735716',
  );
}
