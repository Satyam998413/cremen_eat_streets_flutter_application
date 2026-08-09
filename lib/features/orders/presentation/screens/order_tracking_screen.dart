import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/entities/food_order.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_state.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;

  const OrderTrackingScreen({super.key, required this.orderId});

  Future<void> _makePhoneCall() async {
    final Uri url = Uri.parse('tel:8948998413');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Widget _buildStep(String title, String subtitle, bool isDone, bool isCurrent, IconData icon) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDone || isCurrent ? AppColors.brandPrimary : Colors.grey.shade300,
          ),
          child: Icon(
            icon,
            color: isDone || isCurrent ? Colors.white : Colors.grey.shade600,
          ),
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
                  color: isDone || isCurrent ? AppColors.brandPrimary : Colors.grey,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Status: $orderId'),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          final order = state.activeOrder ??
              state.orders.firstWhere(
                (o) => o.id == orderId,
                orElse: () => FoodOrder(
                  id: orderId,
                  items: const [],
                  totalAmount: 0,
                  status: OrderStatus.preparing,
                  orderType: OrderType.pickup,
                  createdAt: DateTime.now(),
                  customerName: 'Guest',
                  customerPhone: '8948998413',
                ),
              );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Cooking Banner Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: AppColors.brandGradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brandPrimary.withValues(alpha: 0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.soup_kitchen, size: 60, color: Colors.white),
                      SizedBox(height: 12),
                      Text(
                        'Creating Magic...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Our Bawarchi is crafting your perfect street food with fresh ingredients and secret spices!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Stepper Progress
                _buildStep('Order Received', 'Sent to Cremen EatStreets Kitchen', true, order.status == OrderStatus.received, Icons.receipt),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: SizedBox(height: 24, child: VerticalDivider(thickness: 2)),
                ),
                _buildStep('Bawarchi Preparing', 'Fresh ingredients mixing & frying', order.status.index >= OrderStatus.preparing.index, order.status == OrderStatus.preparing, Icons.outdoor_grill),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: SizedBox(height: 24, child: VerticalDivider(thickness: 2)),
                ),
                _buildStep(
                  order.orderType == OrderType.pickup ? 'Ready for Pickup' : 'Out for Delivery',
                  order.orderType == OrderType.pickup ? 'Visit Satyam Baranwal cart in Surat' : 'Rider delivering hot chaat',
                  order.status.index >= OrderStatus.ready.index,
                  order.status == OrderStatus.ready,
                  Icons.local_shipping,
                ),
                const SizedBox(height: 32),

                // Contact Owner Card
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
                            Text(
                              'Satyam Baranwal',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              'Founder & Owner • Cremen EatStreets',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.phone_in_talk, color: AppColors.brandPrimary),
                        onPressed: _makePhoneCall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                AppButton(
                  label: 'Back to Menu',
                  isOutlined: true,
                  onPressed: () => context.go('/'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
