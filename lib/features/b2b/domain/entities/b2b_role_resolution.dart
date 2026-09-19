import 'package:equatable/equatable.dart';
import '../../../auth/domain/entities/account_role.dart';
import 'sales_profile.dart';
import 'wholesaler_profile.dart';

/// What resolving a signed-in user's id against `sales_profiles`/
/// `wholesaler_profiles` came back with — exactly one of the three shapes
/// below, matching [AccountRole].
class B2bRoleResolution extends Equatable {
  const B2bRoleResolution.customer()
      : role = AccountRole.customer,
        salesProfile = null,
        wholesalerProfile = null;

  const B2bRoleResolution.salesman(SalesProfile profile)
      : role = AccountRole.salesman,
        salesProfile = profile,
        wholesalerProfile = null;

  const B2bRoleResolution.wholesaler(WholesalerProfile profile)
      : role = AccountRole.wholesaler,
        salesProfile = null,
        wholesalerProfile = profile;

  final AccountRole role;
  final SalesProfile? salesProfile;
  final WholesalerProfile? wholesalerProfile;

  @override
  List<Object?> get props => [role, salesProfile, wholesalerProfile];
}
