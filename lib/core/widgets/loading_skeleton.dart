import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_colors.dart';

/// Shared shimmer skeleton placeholders, replacing bare `CircularProgressIndicator`s
/// with a shape-matched preview of the content about to load.
class _SkeletonShimmer extends StatelessWidget {
  const _SkeletonShimmer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.darkSurface : Colors.grey.shade300,
      highlightColor: isDark ? AppColors.darkBg : Colors.grey.shade100,
      child: child,
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({this.width, this.height, this.borderRadius = 8});

  final double? width;
  final double? height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// Skeleton for the Home product grid — mirrors [FoodCard]'s image+text shape.
class ShimmerGridSkeleton extends StatelessWidget {
  const ShimmerGridSkeleton({super.key, this.crossAxisCount = 2, this.itemCount = 6});

  final int crossAxisCount;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return _SkeletonShimmer(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.7,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(flex: 5, child: _SkeletonBox(borderRadius: 0)),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _SkeletonBox(width: 90, height: 14),
                      SizedBox(height: 8),
                      _SkeletonBox(width: 60, height: 12),
                      SizedBox(height: 12),
                      _SkeletonBox(width: 50, height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Skeleton for simple list rows — order history, reviews, etc.
class ShimmerListSkeleton extends StatelessWidget {
  const ShimmerListSkeleton({super.key, this.itemCount = 4, this.rowHeight = 84});

  final int itemCount;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    return _SkeletonShimmer(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _SkeletonBox(height: rowHeight, borderRadius: 16),
      ),
    );
  }
}

/// Skeleton for the order-tracking status stepper.
class ShimmerStepperSkeleton extends StatelessWidget {
  const ShimmerStepperSkeleton({super.key, this.stepCount = 5});

  final int stepCount;

  @override
  Widget build(BuildContext context) {
    return _SkeletonShimmer(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const _SkeletonBox(height: 130, borderRadius: 24),
            const SizedBox(height: 28),
            for (var i = 0; i < stepCount; i++) ...[
              Row(
                children: [
                  const _SkeletonBox(width: 44, height: 44, borderRadius: 22),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        _SkeletonBox(width: 120, height: 14),
                        SizedBox(height: 6),
                        _SkeletonBox(width: 160, height: 12),
                      ],
                    ),
                  ),
                ],
              ),
              if (i != stepCount - 1) const Padding(padding: EdgeInsets.only(left: 20), child: SizedBox(height: 24)),
            ],
          ],
        ),
      ),
    );
  }
}
