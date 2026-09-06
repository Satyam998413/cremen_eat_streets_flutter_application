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
}
