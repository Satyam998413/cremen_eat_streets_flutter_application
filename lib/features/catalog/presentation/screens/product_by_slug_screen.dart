import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/error/result.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/error_state_view.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_by_slug_usecase.dart';
import 'product_detail_screen.dart';

/// Resolves a product by its public `slug` before showing it — the landing
/// screen for a `/shop/:slug` deep link (shared product URL, App/Universal
/// Link, or the custom `com.cremeneatstreet.shop://` scheme), where the app
/// has no in-memory catalog to look the product up from yet.
class ProductBySlugScreen extends StatefulWidget {
  const ProductBySlugScreen({super.key, required this.slug});

  final String slug;

  @override
  State<ProductBySlugScreen> createState() => _ProductBySlugScreenState();
}

class _ProductBySlugScreenState extends State<ProductBySlugScreen> {
  late final Future<Result<Product>> _future;

  @override
  void initState() {
    super.initState();
    _future = getIt<GetProductBySlugUseCase>().call(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Result<Product>>(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      gradient: AppColors.brandGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.brandPrimary.withValues(alpha: 0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.fastfood, color: Colors.white, size: 40),
                  )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scaleXY(end: 1.1, duration: 1200.ms, curve: Curves.easeInOut),
                  const SizedBox(height: 24),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
        return switch (snapshot.data!) {
          Success(:final value) => ProductDetailScreen(product: value),
          Failed(:final failure) => Scaffold(
              appBar: AppBar(),
              body: ErrorStateView(message: failure.message),
            ),
        };
      },
    );
  }
}
