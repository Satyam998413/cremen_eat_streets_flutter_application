import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/sales_wholesaler_cubit.dart';
import '../bloc/sales_wholesaler_state.dart';

/// The exact web page a salesman uses to create a brand-new wholesaler
/// account — creating one requires a service-role Supabase call that must
/// run on a trusted server, never in this mobile client, so this app only
/// ever deep-links out to the already-working web flow instead of building
/// a native "create wholesaler" form.
String get addWholesalerUrl => '${AppConfig.apiBaseUrl}/sales/wholesalers/new';

/// A modal bottom sheet listing a salesman's own active wholesalers (loaded
/// by [cubit], already fetched via `wholesaler_profiles` under its "own
/// salesman read" RLS policy) to pick who the next order is placed for, plus
/// an "Add wholesaler" action that opens the web onboarding page externally.
Future<void> showWholesalerPickerSheet(BuildContext context, SalesWholesalerCubit cubit) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (sheetContext) => _WholesalerPickerSheetContent(cubit: cubit),
  );
}

class _WholesalerPickerSheetContent extends StatelessWidget {
  const _WholesalerPickerSheetContent({required this.cubit});

  final SalesWholesalerCubit cubit;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Order for which wholesaler?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                TextButton.icon(
                  onPressed: () => launchUrl(Uri.parse(addWholesalerUrl), mode: LaunchMode.externalApplication),
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('Add wholesaler'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
              child: BlocBuilder<SalesWholesalerCubit, SalesWholesalerState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state.errorMessage != null) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(state.errorMessage!, style: const TextStyle(color: AppColors.spicyRed)),
                    );
                  }
                  if (state.wholesalers.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'No wholesalers assigned to you yet — add one to get started.',
                        style: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.wholesalers.length,
                    itemBuilder: (context, index) {
                      final wholesaler = state.wholesalers[index];
                      final isSelected = state.selected?.id == wholesaler.id;
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(wholesaler.displayName, style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(
                          wholesaler.addressSummary != null
                              ? '${wholesaler.phone} · ${wholesaler.addressSummary}'
                              : wholesaler.phone,
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle, color: AppColors.brandPrimary)
                            : null,
                        onTap: () {
                          cubit.select(wholesaler);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A compact "Ordering for: X — Change" row for the B2B catalog/checkout
/// screens. Shows nothing until a wholesaler list load has at least been
/// attempted, so it doesn't flash a misleading "no wholesaler" state before
/// [SalesWholesalerCubit.loadFor] has had a chance to run.
class WholesalerBanner extends StatelessWidget {
  const WholesalerBanner({super.key, required this.cubit});

  final SalesWholesalerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesWholesalerCubit, SalesWholesalerState>(
      bloc: cubit,
      builder: (context, state) {
        final selected = state.selected;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.brandPrimary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.brandPrimary.withValues(alpha: 0.25)),
          ),
          child: Row(
            children: [
              const Icon(Icons.storefront_outlined, size: 18, color: AppColors.brandPrimary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  selected != null ? 'Ordering for: ${selected.displayName}' : 'Select a wholesaler to order for',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                onPressed: () => showWholesalerPickerSheet(context, cubit),
                child: Text(selected != null ? 'Change' : 'Select'),
              ),
            ],
          ),
        );
      },
    );
  }
}
