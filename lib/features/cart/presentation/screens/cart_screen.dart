import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/quantity_selector.dart';
import '../../../../core/widgets/responsive_product_image.dart';
import '../../../orders/domain/entities/food_order.dart';
import '../../../orders/presentation/bloc/order_bloc.dart';
import '../../../orders/presentation/bloc/order_event.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  OrderType _orderType = OrderType.pickup;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart & Checkout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              context.read<CartBloc>().add(CartCleared());
            },
            tooltip: 'Clear Cart',
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 80, color: AppColors.brandPrimary),
                  const SizedBox(height: 16),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Add some delicious Surat street food!'),
                  const SizedBox(height: 24),
                  AppButton(
                    label: 'Browse Menu',
                    onPressed: () => context.go('/'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: ResponsiveProductImage(
                              imageUrl: item.product.imageUrl,
                              width: 65,
                              height: 65,
                              fit: BoxFit.cover,
                              borderRadius: BorderRadius.circular(12),
                              fallbackColor: AppColors.brandPrimary.withValues(alpha: 0.12),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Spice: ${item.spiceLevel}${item.hasExtraCheese ? ' • Extra Cheese' : ''}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₹${item.totalPrice.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.brandPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QuantitySelector(
                            quantity: item.quantity,
                            onIncrement: () {
                              context.read<CartBloc>().add(CartItemQuantityChanged(item.id, 1));
                            },
                            onDecrement: () {
                              context.read<CartBloc>().add(CartItemQuantityChanged(item.id, -1));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Order Type Selector
                const Text(
                  'Order Type',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: const Center(child: Text('Pickup at Cart')),
                        selected: _orderType == OrderType.pickup,
                        selectedColor: AppColors.brandPrimary,
                        onSelected: (val) {
                          if (val) setState(() => _orderType = OrderType.pickup);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ChoiceChip(
                        label: const Center(child: Text('Direct Delivery')),
                        selected: _orderType == OrderType.delivery,
                        selectedColor: AppColors.brandPrimary,
                        onSelected: (val) {
                          if (val) setState(() => _orderType = OrderType.delivery);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Customer Details
                const Text(
                  'Customer Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                if (_orderType == OrderType.delivery) ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Delivery Address in Surat',
                      prefixIcon: const Icon(Icons.location_on),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
                const SizedBox(height: 24),

                // Bill Summary
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal'),
                          Text('₹${state.totalAmount.toStringAsFixed(0)}'),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Delivery / Cart Service Fee'),
                          Text(_orderType == OrderType.delivery ? '₹20' : 'FREE',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.successGreen)),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Grand Total',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            '₹${(state.totalAmount + (_orderType == OrderType.delivery ? 20 : 0)).toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                              color: AppColors.brandPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Place Order CTA
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: 'Place Order Now',
                    icon: Icons.check_circle_outline,
                    onPressed: () {
                      if (_nameController.text.trim().isEmpty || _phoneController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter your name and phone number.')),
                        );
                        return;
                      }

                      final newOrder = FoodOrder(
                        id: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                        items: List.from(state.items),
                        totalAmount: state.totalAmount + (_orderType == OrderType.delivery ? 20 : 0),
                        status: OrderStatus.received,
                        orderType: _orderType,
                        createdAt: DateTime.now(),
                        customerName: _nameController.text.trim(),
                        customerPhone: _phoneController.text.trim(),
                        deliveryAddress: _addressController.text.trim(),
                      );

                      context.read<OrderBloc>().add(OrderPlaced(newOrder));
                      context.read<CartBloc>().add(CartCleared());

                      context.go('/orders/${newOrder.id}');
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
