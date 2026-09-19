import '../../../../core/error/result.dart';
import '../entities/b2b_role_resolution.dart';
import '../entities/wholesaler_profile.dart';

abstract class B2bRepository {
  /// Resolves which of `customer`/`salesman`/`wholesaler` [userId] is, by
  /// checking for an *active* row in `sales_profiles` then
  /// `wholesaler_profiles` — a suspended row in either table resolves to
  /// plain `customer` rather than granting B2B access, since this app has no
  /// "account suspended" screen of its own to show instead.
  Future<Result<B2bRoleResolution>> resolveRole(String userId);

  /// A salesman's own active wholesalers, for the "ordering for" picker.
  Future<Result<List<WholesalerProfile>>> getAssignedWholesalers(String salesId);
}
