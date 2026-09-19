import '../../../../core/pricing/pricing_resolver.dart';

/// The three account types this backend now recognizes — see
/// `sales_profiles`/`wholesaler_profiles` (cremen_eat_streets B2B ordering
/// channel). Resolved once per session by [AuthBloc] from whichever of those
/// two tables (if either) has an active row for the signed-in user id; a
/// customer is simply the absence of both.
enum AccountRole { customer, salesman, wholesaler }

extension AccountRoleX on AccountRole {
  /// A customer always orders at retail; a salesman places orders on behalf
  /// of a wholesaler and a wholesaler orders for themselves — both at the
  /// wholesale price list.
  PricingTier get pricingTier => this == AccountRole.customer ? PricingTier.retail : PricingTier.wholesale;

  /// Matches the `orders.channel` check constraint this role's order should
  /// be created under ('retail' | 'sales' | 'wholesale').
  String get orderChannel => switch (this) {
        AccountRole.customer => 'retail',
        AccountRole.salesman => 'sales',
        AccountRole.wholesaler => 'wholesale',
      };
}
