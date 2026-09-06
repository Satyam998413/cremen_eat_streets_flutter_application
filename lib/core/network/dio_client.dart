import 'package:dio/dio.dart';
import '../config/app_config.dart';

/// One shared Dio instance for the handful of custom Next.js routes this app
/// calls directly (create-order, verify, geocode/reverse) — every other
/// backend read/write goes through supabase_flutter's own client instead.
Dio buildDioClient() {
  return Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      // Accept 4xx so the caller can read the {error} body itself instead of
      // Dio throwing — these routes return a meaningful JSON error message
      // on 400/401/404 that's worth showing the user verbatim.
      validateStatus: (status) => status != null && status < 500,
    ),
  );
}
