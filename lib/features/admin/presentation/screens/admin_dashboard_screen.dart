import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../orders/domain/entities/food_order.dart';
import '../../../orders/presentation/bloc/order_bloc.dart';
import '../../../orders/presentation/bloc/order_event.dart';
import '../../../orders/presentation/bloc/order_state.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text('Owner Console', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Satyam Baranwal • Cremen EatStreets', style: TextStyle(fontSize: 12, color: AppColors.brandPrimary)),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.home_rounded),
          onPressed: () => context.go('/'),
          tooltip: 'Back to Customer Menu',
        ),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.storefront_outlined, color: AppColors.brandPrimary),
            label: const Text('Menu', style: TextStyle(color: AppColors.brandPrimary, fontWeight: FontWeight.bold)),
            onPressed: () => context.go('/'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ],
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state.orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.kitchen_outlined, size: 64, color: AppColors.brandPrimary),
                  const SizedBox(height: 12),
                  const Text(
                    'Kitchen Queue Empty',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  const Text('Incoming customer orders will appear here in real-time.'),
                  const SizedBox(height: 28),
                  OutlinedButton.icon(
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.home_rounded, color: AppColors.brandPrimary),
                    label: const Text(
                      'Go to Customer Menu',
                      style: TextStyle(color: AppColors.brandPrimary, fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.brandPrimary, width: 1.5),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Quick nav back to customer view
              Container(
                margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.brandPrimary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.brandPrimary, size: 18),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Owner mode active — tap Home to return to customer view',
                        style: TextStyle(fontSize: 13, color: AppColors.brandPrimary, fontWeight: FontWeight.w600),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/'),
                      child: const Icon(Icons.home_rounded, color: AppColors.brandPrimary),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.orders.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final order = state.orders[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.cardBorder, width: 1.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order.id,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Chip(
                                backgroundColor: AppColors.brandPrimary.withValues(alpha: 0.15),
                                label: Text(
                                  order.orderType.name.toUpperCase(),
                                  style: const TextStyle(
                                    color: AppColors.brandPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Customer: ${order.customerName} (${order.customerPhone})',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          if (order.deliveryAddress != null && order.deliveryAddress!.isNotEmpty)
                            Text(
                              'Address: ${order.deliveryAddress}',
                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          const Divider(height: 20),

                          // Items list
                          Column(
                            children: order.items.map((item) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${item.quantity}x ${item.product.name} (${item.spiceLevel})'),
                                    Text('₹${item.totalPrice.toStringAsFixed(0)}'),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          const Divider(height: 20),

                          // Status update CTAs
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total: ₹${order.totalAmount.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: AppColors.brandPrimary,
                                ),
                              ),
                              PopupMenuButton<OrderStatus>(
                                onSelected: (newStatus) {
                                  context.read<OrderBloc>().add(OrderStatusUpdated(order.id, newStatus));
                                },
                                itemBuilder: (_) => const [
                                  PopupMenuItem(value: OrderStatus.received, child: Text('Mark Received')),
                                  PopupMenuItem(value: OrderStatus.preparing, child: Text('Mark Preparing')),
                                  PopupMenuItem(value: OrderStatus.ready, child: Text('Mark Ready')),
                                  PopupMenuItem(value: OrderStatus.completed, child: Text('Mark Completed')),
                                ],
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    gradient: AppColors.brandGradient,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        order.status.name.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Icon(Icons.arrow_drop_down, color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
