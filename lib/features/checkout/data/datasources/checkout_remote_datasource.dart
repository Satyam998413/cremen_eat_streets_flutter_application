import 'package:dio/dio.dart';

/// Thin wrapper around the two custom Next.js checkout routes (see
/// plans/platform-overview.md, cremen_eat_streets, Step 6b/10). Returns the
/// raw Dio Response — the repository is what interprets status codes and
/// error bodies into a typed Result.
class CheckoutRemoteDataSource {
  CheckoutRemoteDataSource(this._dio);

  final Dio _dio;

  Future<Response<dynamic>> createOrder(Map<String, dynamic> payload, {String? bearerToken}) {
    return _dio.post(
      '/api/checkout/create-order',
      data: payload,
      options: Options(headers: bearerToken != null ? {'Authorization': 'Bearer $bearerToken'} : null),
    );
  }

  Future<Response<dynamic>> verifyPayment(Map<String, dynamic> payload) {
    return _dio.post('/api/checkout/verify', data: payload);
  }
}
