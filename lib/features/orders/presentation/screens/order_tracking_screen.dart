import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/error_state_view.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../domain/entities/food_order.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';

/// [orderId] is actually the order's public_token — every entry point into
/// this screen (checkout success, order history's "Track Order") passes
/// that, not the raw orders.id (see OrderRepository.getByPublicToken).
class OrderTrackingScreen extends StatefulWidget {
  final String orderId;

  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(OrderEvent.detailRequested(widget.orderId));
  }

  Future<void> _makePhoneCall() async {
    final Uri url = Uri.parse('tel:8948998413');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Widget _buildStep(
    BuildContext context,
    String title,
    String subtitle,
    bool isDone,
    bool isCurrent,
    IconData icon,
    int index,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inactiveCircle = isDark ? AppColors.darkSurface : Colors.grey.shade300;
    final inactiveIcon = isDark ? AppColors.textSecondaryDark : Colors.grey.shade600;
    final inactiveText = isDark ? AppColors.textSecondaryDark : Colors.grey;

    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDone || isCurrent ? AppColors.brandPrimary : inactiveCircle,
          ),
          child: Icon(icon, color: isDone || isCurrent ? Colors.white : inactiveIcon),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDone || isCurrent ? AppColors.brandPrimary : inactiveText,
                ),
              ),
              Text(subtitle, style: TextStyle(fontSize: 13, color: inactiveText)),
            ],
          ),
        ),
      ],
    ).animate(delay: Duration(milliseconds: 80 * index)).fadeIn(duration: 350.ms).slideX(begin: -0.1, curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Status')),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading || state is OrderInitial) {
            return const ShimmerStepperSkeleton();
          }
          if (state is OrderFailure) {
            return ErrorStateView(message: state.message, onAction: () => context.go('/'));
          }
          if (state is! OrderDetailLoaded) {
            return ErrorStateView(message: 'Order not found.', onAction: () => context.go('/'));
          }
          final order = state.order;

          if (order.status == OrderStatus.cancelled) {
            return ErrorStateView(
              icon: Icons.cancel_outlined,
              message: 'This order was cancelled.',
              onAction: () => context.go('/'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: AppColors.brandGradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(color: AppColors.brandPrimary.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 6)),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.soup_kitchen, size: 60, color: Colors.white),
                      const SizedBox(height: 12),
                      Text(
                        order.orderNumber ?? 'Order ${order.id}',
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Our team is preparing your order with fresh ingredients!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                _buildStep(
                  context,
                  'Payment Pending',
                  'Waiting for payment confirmation',
                  order.status.index >= OrderStatus.pendingPayment.index,
                  order.status == OrderStatus.pendingPayment,
                  Icons.hourglass_top,
                  0,
                ),
                const Padding(padding: EdgeInsets.only(left: 20), child: SizedBox(height: 24, child: VerticalDivider(thickness: 2))),
                _buildStep(
                  context,
                  'Order Confirmed',
                  'Payment received, sent to the kitchen',
                  order.status.index >= OrderStatus.confirmed.index,
                  order.status == OrderStatus.confirmed,
                  Icons.receipt,
                  1,
                ),
                const Padding(padding: EdgeInsets.only(left: 20), child: SizedBox(height: 24, child: VerticalDivider(thickness: 2))),
                _buildStep(
                  context,
                  'Preparing',
                  'Fresh ingredients mixing & frying',
                  order.status.index >= OrderStatus.processing.index,
                  order.status == OrderStatus.processing,
                  Icons.outdoor_grill,
                  2,
                ),
                const Padding(padding: EdgeInsets.only(left: 20), child: SizedBox(height: 24, child: VerticalDivider(thickness: 2))),
                _buildStep(
                  context,
                  order.orderType == OrderType.pickup ? 'Ready for Pickup' : 'Out for Delivery',
                  order.orderType == OrderType.pickup ? 'Visit the cart in Surat' : 'Rider on the way',
                  order.status.index >= OrderStatus.dispatched.index,
                  order.status == OrderStatus.dispatched,
                  Icons.local_shipping,
                  3,
                ),
                const Padding(padding: EdgeInsets.only(left: 20), child: SizedBox(height: 24, child: VerticalDivider(thickness: 2))),
                _buildStep(
                  context,
                  'Delivered',
                  'Enjoy your meal!',
                  order.status == OrderStatus.delivered,
                  order.status == OrderStatus.delivered,
                  Icons.check_circle,
                  4,
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.brandPrimary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.brandPrimary,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cremen Eat Streets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('Questions about your order?', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                      Semantics(
                        label: 'Call Cremen Eat Streets',
                        button: true,
                        child: IconButton(
                          icon: const Icon(Icons.phone_in_talk, color: AppColors.brandPrimary),
                          onPressed: _makePhoneCall,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AppButton(label: 'Back to Menu', isOutlined: true, onPressed: () => context.go('/')),
              ],
            ),
          );
        },
      ),
    );
  }
}
