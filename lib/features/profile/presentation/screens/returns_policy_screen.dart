import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Static content, matching the website's own /policies/returns page
/// (see plans/platform-overview.md, cremen_eat_streets, Step 2a).
class ReturnsPolicyScreen extends StatelessWidget {
  const ReturnsPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Returns Policy')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('No Returns / Refunds', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                  .animate()
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOutCubic),
              const SizedBox(height: 12),
              const Text(
                'Cremen Eat Streets prepares fresh street food to order. Because of the '
                'perishable nature of our products, we are unable to accept returns, '
                'exchanges, or refunds once an order has been placed and confirmed.\n\n'
                'If there is a genuine issue with your order — a wrong item, a missing '
                'item, or a quality concern — please contact us directly and we will make '
                'it right.',
                style: TextStyle(fontSize: 15, height: 1.6),
              )
                  .animate(delay: 100.ms)
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: 0.2, duration: 350.ms, curve: Curves.easeOutCubic),
            ],
          ),
        ),
      ),
    );
  }
}
