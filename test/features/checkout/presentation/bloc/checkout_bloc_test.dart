import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cremen_eatstreet_shop_application/core/error/failure.dart';
import 'package:cremen_eatstreet_shop_application/core/error/result.dart';
import 'package:cremen_eatstreet_shop_application/features/checkout/domain/entities/created_order.dart';
import 'package:cremen_eatstreet_shop_application/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:cremen_eatstreet_shop_application/features/checkout/domain/usecases/create_order_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/checkout/domain/usecases/verify_payment_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/checkout/presentation/bloc/checkout_event.dart';
import 'package:cremen_eatstreet_shop_application/features/checkout/presentation/bloc/checkout_state.dart';

class _MockCheckoutRepository extends Mock implements CheckoutRepository {}

void main() {
  late _MockCheckoutRepository repository;
  late CreateOrderUseCase createOrder;
  late VerifyPaymentUseCase verifyPayment;

  const createdOrder = CreatedOrder(
    orderId: 'order-1',
    razorpayOrderId: 'rzp-1',
    amount: 5000,
    currency: 'INR',
    keyId: 'rzp_test_key',
    prefillName: 'Test User',
    prefillContact: '9999999999',
  );

  setUp(() {
    repository = _MockCheckoutRepository();
    createOrder = CreateOrderUseCase(repository);
    verifyPayment = VerifyPaymentUseCase(repository);
    registerFallbackValue(<dynamic>[]);
  });

  CheckoutBloc buildBloc() => CheckoutBloc(createOrder: createOrder, verifyPayment: verifyPayment);

  blocTest<CheckoutBloc, CheckoutState>(
    'emits [creatingOrder, awaitingPayment] when create-order succeeds',
    setUp: () => when(() => repository.createOrder(
          items: any(named: 'items'),
          fulfillmentType: any(named: 'fulfillmentType'),
          customerName: any(named: 'customerName'),
          customerPhone: any(named: 'customerPhone'),
          noReturnAck: any(named: 'noReturnAck'),
          customerEmail: any(named: 'customerEmail'),
          shippingAddress: any(named: 'shippingAddress'),
          notes: any(named: 'notes'),
        )).thenAnswer((_) async => const Success(createdOrder)),
    build: buildBloc,
    act: (bloc) => bloc.add(const CheckoutEvent.submitted(
      items: [],
      fulfillmentType: 'pickup',
      customerName: 'Test User',
      customerPhone: '9999999999',
      noReturnAck: true,
    )),
    expect: () => [
      const CheckoutState.creatingOrder(),
      const CheckoutState.awaitingPayment(
        orderId: 'order-1',
        razorpayOrderId: 'rzp-1',
        amount: 5000,
        currency: 'INR',
        keyId: 'rzp_test_key',
        prefillName: 'Test User',
        prefillContact: '9999999999',
      ),
    ],
  );

  blocTest<CheckoutBloc, CheckoutState>(
    'emits [creatingOrder, failure] when create-order is rejected (e.g. missing no-return ack)',
    setUp: () => when(() => repository.createOrder(
          items: any(named: 'items'),
          fulfillmentType: any(named: 'fulfillmentType'),
          customerName: any(named: 'customerName'),
          customerPhone: any(named: 'customerPhone'),
          noReturnAck: any(named: 'noReturnAck'),
          customerEmail: any(named: 'customerEmail'),
          shippingAddress: any(named: 'shippingAddress'),
          notes: any(named: 'notes'),
        )).thenAnswer((_) async => const Failed(ValidationFailure('Cart is empty.'))),
    build: buildBloc,
    act: (bloc) => bloc.add(const CheckoutEvent.submitted(
      items: [],
      fulfillmentType: 'pickup',
      customerName: 'Test User',
      customerPhone: '9999999999',
      noReturnAck: true,
    )),
    expect: () => [
      const CheckoutState.creatingOrder(),
      const CheckoutState.failure('Cart is empty.'),
    ],
  );

  blocTest<CheckoutBloc, CheckoutState>(
    'emits [verifyingPayment, success] when payment verification succeeds',
    setUp: () => when(() => repository.verifyPayment(
          orderId: any(named: 'orderId'),
          razorpayOrderId: any(named: 'razorpayOrderId'),
          razorpayPaymentId: any(named: 'razorpayPaymentId'),
          razorpaySignature: any(named: 'razorpaySignature'),
        )).thenAnswer((_) async => const Success('public-token-1')),
    build: buildBloc,
    seed: () => const CheckoutState.awaitingPayment(
      orderId: 'order-1',
      razorpayOrderId: 'rzp-1',
      amount: 5000,
      currency: 'INR',
      keyId: 'rzp_test_key',
      prefillName: 'Test User',
      prefillContact: '9999999999',
    ),
    act: (bloc) => bloc.add(const CheckoutEvent.paymentSucceeded('pay-1', 'sig-1')),
    expect: () => [
      const CheckoutState.verifyingPayment(),
      const CheckoutState.success('public-token-1'),
    ],
  );

  blocTest<CheckoutBloc, CheckoutState>(
    'emits failure when the Razorpay checkout sheet itself reports an error',
    build: buildBloc,
    act: (bloc) => bloc.add(const CheckoutEvent.paymentFailed('Payment was cancelled.')),
    expect: () => [const CheckoutState.failure('Payment was cancelled.')],
  );
}
