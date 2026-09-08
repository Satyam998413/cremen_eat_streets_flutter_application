import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ResponsiveProductImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double aspectRatio;
  final BoxFit fit;
  final String placeholderAsset;
  final BorderRadiusGeometry? borderRadius;
  final Color? fallbackColor;
  final IconData fallbackIcon;

  /// When set, wraps the image in a [Hero] with this tag so navigating to a
  /// screen with a matching tag (e.g. the same product's detail page) gets a
  /// shared-element transition for free.
  final String? heroTag;

  const ResponsiveProductImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.aspectRatio = 4 / 3,
    this.fit = BoxFit.cover,
    this.placeholderAsset = 'assets/images/cremen_logo.jpg',
    this.borderRadius,
    this.fallbackColor,
    this.fallbackIcon = Icons.fastfood,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final hasAssetPath = imageUrl.trim().startsWith('assets/');
    final hasRemoteScheme = Uri.tryParse(imageUrl)?.hasScheme ?? false;
    final bool shouldUseRemote = hasRemoteScheme && imageUrl.trim().isNotEmpty;

    final imageWidget = shouldUseRemote
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            width: width,
            height: height,
            fit: fit,
            fadeInDuration: const Duration(milliseconds: 300),
            fadeInCurve: Curves.easeOut,
            placeholder: (context, url) => _buildShimmerPlaceholder(context),
            errorWidget: (context, url, error) => _buildFallback(),
          )
        : Image.asset(
            hasAssetPath ? imageUrl : placeholderAsset,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) => _buildFallback(),
          );

    final clipped = height != null || width != null
        ? ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: SizedBox(
              width: width,
              height: height,
              child: imageWidget,
            ),
          )
        : ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: imageWidget,
            ),
          );

    if (heroTag == null) return clipped;
    return Hero(tag: heroTag!, child: clipped);
  }

  Widget _buildShimmerPlaceholder(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
      highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
      child: Container(width: width, height: height, color: Colors.white),
    );
  }

  Widget _buildFallback() {
    return Container(
      width: width,
      height: height,
      color: fallbackColor ?? Colors.orange.shade50,
      child: Image.asset(
        placeholderAsset,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
