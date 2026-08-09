import 'package:flutter/material.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    final hasAssetPath = imageUrl.trim().startsWith('assets/');
    final hasRemoteScheme = Uri.tryParse(imageUrl)?.hasScheme ?? false;
    final bool shouldUseRemote = hasRemoteScheme && imageUrl.trim().isNotEmpty;

    final imageWidget = shouldUseRemote
        ? Image.network(
            imageUrl,
            width: width,
            height: height,
            fit: fit,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                width: width,
                height: height,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => _buildFallback(),
          )
        : Image.asset(
            hasAssetPath ? imageUrl : placeholderAsset,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) => _buildFallback(),
          );

    if (height != null || width != null) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: SizedBox(
          width: width,
          height: height,
          child: imageWidget,
        ),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: imageWidget,
      ),
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
