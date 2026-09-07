import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/result.dart';
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
    _future = context.read<GetProductBySlugUseCase>().call(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Result<Product>>(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return switch (snapshot.data!) {
          Success(:final value) => ProductDetailScreen(product: value),
          Failed(:final failure) => Scaffold(
              appBar: AppBar(),
              body: Center(child: Text(failure.message)),
            ),
        };
      },
    );
  }
}
