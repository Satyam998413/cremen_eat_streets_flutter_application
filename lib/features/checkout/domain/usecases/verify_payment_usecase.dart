import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/checkout_repository.dart';

class VerifyPaymentParams {
  const VerifyPaymentParams({
    required this.orderId,
    required this.razorpayOrderId,
    required this.razorpayPaymentId,
    required this.razorpaySignature,
  });

  final String orderId;
  final String razorpayOrderId;
  final String razorpayPaymentId;
  final String razorpaySignature;
}

class VerifyPaymentUseCase implements UseCase<String, VerifyPaymentParams> {
  const VerifyPaymentUseCase(this._repository);

  final CheckoutRepository _repository;

  @override
  Future<Result<String>> call(VerifyPaymentParams params) {
    return _repository.verifyPayment(
      orderId: params.orderId,
      razorpayOrderId: params.razorpayOrderId,
      razorpayPaymentId: params.razorpayPaymentId,
      razorpaySignature: params.razorpaySignature,
    );
  }
}
