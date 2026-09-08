import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/error_state_view.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(const OrderEvent.historyRequested());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading || state is OrderInitial) {
            return const ShimmerListSkeleton();
          }
          if (state is OrderFailure) {
            return ErrorStateView(
              message: 'Could not load your orders: ${state.message}',
              actionLabel: 'Retry',
              onAction: () => context.read<OrderBloc>().add(const OrderEvent.historyRequested()),
            );
          }
          final orders = state is OrderHistoryLoaded ? state.orders : const [];
          if (orders.isEmpty) {
            return const EmptyStateView(
              icon: Icons.history,
              title: 'No past orders yet.',
              subtitle: 'Log in to see orders placed while signed in.',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final order = orders[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.orderNumber ?? order.id,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.brandPrimary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            order.status.name.toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.brandPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      DateFormat('dd MMM yyyy, hh:mm a').format(order.createdAt),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const Divider(height: 16),
                    Text(
                      '${order.items.length} items • ₹${order.totalAmount.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => context.push('/orders/${order.publicToken ?? order.id}'),
                        icon: const Icon(Icons.track_changes, size: 16),
                        label: const Text('Track Order'),
                      ),
                    ),
                  ],
                ),
              )
                  .animate(delay: Duration(milliseconds: 60 * index))
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOutCubic);
            },
          );
        },
      ),
    );
  }
}
