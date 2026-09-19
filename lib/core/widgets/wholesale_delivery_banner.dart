import 'package:flutter/material.dart';
import '../pricing/wholesale_fee_calculator.dart';
import '../theme/app_colors.dart';

/// A visible preview of `calcWholesaleDeliveryFee`'s 20-packet threshold —
/// shared by the B2B catalog screen and the B2B checkout order summary. The
/// server remains the source of truth for the actual charged delivery fee;
/// this is a client-side preview only, same role as the retail flat-₹20
/// preview it sits alongside on checkout.
class WholesaleDeliveryBanner extends StatelessWidget {
  const WholesaleDeliveryBanner({super.key, required this.packetCount});

  final int packetCount;

  @override
  Widget build(BuildContext context) {
    final remaining = WholesaleFeeCalculator.minPackets - packetCount;
    final isFree = remaining <= 0;
    final message = isFree
        ? '$packetCount/${WholesaleFeeCalculator.minPackets} packets — delivery is free'
        : '$packetCount/${WholesaleFeeCalculator.minPackets} packets — add $remaining more for free delivery, '
            'otherwise a flat ₹${WholesaleFeeCalculator.underMinDeliveryFee.toStringAsFixed(0)} delivery charge applies';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: (isFree ? AppColors.successGreen : AppColors.brandSecondary).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            isFree ? Icons.local_shipping : Icons.local_shipping_outlined,
            size: 18,
            color: isFree ? AppColors.successGreen : AppColors.brandSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(message, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
