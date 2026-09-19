import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/domain/entities/account_role.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import 'pricing_resolver.dart';

/// Resolves the [PricingTier] that should apply to a price shown/added right
/// now, from the signed-in account's resolved role in [AuthBloc] —
/// retail for a customer or a signed-out visitor, wholesale for a salesman
/// or wholesaler account.
///
/// Guarded against a missing [AuthBloc] ancestor: several existing widget
/// tests (golden_test.dart, product_detail_screen_test.dart) pump FoodCard /
/// ProductDetailScreen on their own with no MultiBlocProvider above them.
/// Those fall through to retail, identical to this app's pricing behavior
/// before this feature existed — never a hard crash just because a screen
/// carrying pricing UI was pumped in isolation.
PricingTier watchPricingTier(BuildContext context) {
  try {
    final state = context.watch<AuthBloc>().state;
    if (state case Authenticated(:final role)) {
      return role.pricingTier;
    }
  } on ProviderNotFoundException {
    // No AuthBloc ancestor in this widget tree — fall through to retail.
  }
  return PricingTier.retail;
}
