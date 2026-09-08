import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../entities/created_order.dart';
import '../repositories/checkout_repository.dart';

class CreateOrderParams {
  const CreateOrderParams({
    required this.items,
    required this.fulfillmentType,
    required this.customerName,
    required this.customerPhone,
    required this.noReturnAck,
    this.customerEmail,
    this.shippingAddress,
    this.notes,
  });

  final List<CartItem> items;
  final String fulfillmentType; // 'pickup' | 'local_delivery' | 'shipping'
  final String customerName;
  final String customerPhone;
  final bool noReturnAck;
  final String? customerEmail;
  final Map<String, dynamic>? shippingAddress;
  final String? notes;
}

@lazySingleton
class CreateOrderUseCase implements UseCase<CreatedOrder, CreateOrderParams> {
  const CreateOrderUseCase(this._repository);

  final CheckoutRepository _repository;

  @override
  Future<Result<CreatedOrder>> call(CreateOrderParams params) {
    return _repository.createOrder(
      items: params.items,
      fulfillmentType: params.fulfillmentType,
      customerName: params.customerName,
      customerPhone: params.customerPhone,
      noReturnAck: params.noReturnAck,
      customerEmail: params.customerEmail,
      shippingAddress: params.shippingAddress,
      notes: params.notes,
    );
  }
}
