import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../domain/entities/created_order.dart';
import '../../domain/entities/resolved_address.dart';
import '../../domain/repositories/checkout_repository.dart';
import '../datasources/checkout_remote_datasource.dart';

@LazySingleton(as: CheckoutRepository)
class CheckoutRepositoryImpl implements CheckoutRepository {
  CheckoutRepositoryImpl(this._remote);

  final CheckoutRemoteDataSource _remote;

  @override
  Future<Result<CreatedOrder>> createOrder({
    required List<CartItem> items,
    required String fulfillmentType,
    required String customerName,
    required String customerPhone,
    required bool noReturnAck,
    String? customerEmail,
    Map<String, dynamic>? shippingAddress,
    String? notes,
    String channel = 'retail',
    String paymentMethod = 'razorpay',
    String? wholesalerId,
  }) async {
    try {
      final payload = {
        'items': items
            .map((item) => {
                  'productId': item.product.id,
                  'quantity': item.quantity,
                  if (item.variantLabel != null) 'variantLabel': item.variantLabel,
                })
            .toList(),
        'customerName': customerName,
        'customerPhone': customerPhone,
        'fulfillmentType': fulfillmentType,
        'noReturnAck': noReturnAck,
        'customerEmail': ?customerEmail,
        'shippingAddress': ?shippingAddress,
        'notes': ?notes,
        // Omitted entirely for a retail order — 'omit or "retail" = no
        // behavior change from today' per the create-order contract, and
        // omitting keeps this payload byte-for-byte what this app already
        // sent before the B2B ordering channel existed.
        if (channel != 'retail') ...{
          'channel': channel,
          'paymentMethod': paymentMethod,
          'wholesalerId': ?wholesalerId,
        },
      };
      // Supabase's own session — not this app's HTTP session — so a
      // logged-in customer's order gets attributed server-side via the
      // Authorization header (see create-order/route.js's Bearer-token path).
      final token = Supabase.instance.client.auth.currentSession?.accessToken;
      final response = await _remote.createOrder(payload, bearerToken: token);
      final data = Map<String, dynamic>.from(response.data as Map);

      if (response.statusCode == 200) {
        if (data['codConfirmed'] == true) {
          return Success(CreatedOrder(
            orderId: data['orderId'] as String,
            codConfirmed: true,
            publicToken: data['publicToken'] as String?,
          ));
        }
        final prefill = data['prefill'] as Map<String, dynamic>? ?? const {};
        return Success(CreatedOrder(
          orderId: data['orderId'] as String,
          razorpayOrderId: data['razorpayOrderId'] as String?,
          amount: data['amount'] as int?,
          currency: data['currency'] as String?,
          keyId: data['keyId'] as String?,
          prefillName: (prefill['name'] as String?) ?? customerName,
          prefillContact: (prefill['contact'] as String?) ?? customerPhone,
          prefillEmail: prefill['email'] as String?,
        ));
      }
      return Failed(ValidationFailure(data['error'] as String? ?? 'Could not place your order.'));
    } on DioException catch (e) {
      return Failed(NetworkFailure(e.message ?? 'Network error — please check your connection.'));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<String>> verifyPayment({
    required String orderId,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
  }) async {
    try {
      final response = await _remote.verifyPayment({
        'orderId': orderId,
        'razorpay_order_id': razorpayOrderId,
        'razorpay_payment_id': razorpayPaymentId,
        'razorpay_signature': razorpaySignature,
      });
      final data = Map<String, dynamic>.from(response.data as Map);
      if (response.statusCode == 200) {
        return Success(data['publicToken'] as String);
      }
      return Failed(ValidationFailure(data['error'] as String? ?? 'Payment verification failed.'));
    } on DioException catch (e) {
      return Failed(NetworkFailure(e.message ?? 'Network error — please check your connection.'));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<ResolvedAddress>> reverseGeocode({required double lat, required double lon}) async {
    try {
      final response = await _remote.reverseGeocode(lat: lat, lon: lon);
      final data = Map<String, dynamic>.from(response.data as Map);
      if (response.statusCode == 200) {
        return Success(ResolvedAddress(
          line1: data['line1'] as String? ?? '',
          city: data['city'] as String? ?? '',
          state: data['state'] as String? ?? '',
          pincode: data['pincode'] as String? ?? '',
          displayName: data['displayName'] as String? ?? '',
        ));
      }
      return Failed(ValidationFailure(data['error'] as String? ?? 'Could not resolve that location.'));
    } on DioException catch (e) {
      return Failed(NetworkFailure(e.message ?? 'Network error — please check your connection.'));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }
}
