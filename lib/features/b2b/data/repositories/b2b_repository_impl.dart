import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show PostgrestException;
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/b2b_role_resolution.dart';
import '../../domain/entities/sales_profile.dart';
import '../../domain/entities/wholesaler_profile.dart';
import '../../domain/repositories/b2b_repository.dart';
import '../datasources/b2b_remote_datasource.dart';

@LazySingleton(as: B2bRepository)
class B2bRepositoryImpl implements B2bRepository {
  B2bRepositoryImpl(this._remote);

  final B2bRemoteDataSource _remote;

  @override
  Future<Result<B2bRoleResolution>> resolveRole(String userId) async {
    try {
      // Both checked up front (one round trip each, in parallel) rather than
      // sequentially short-circuiting — a signed-in user is a customer far
      // more often than not, so optimizing for "both come back empty" is the
      // common case, not the two-lookups-in-a-row worst case.
      final rows = await Future.wait<Map<String, dynamic>?>([
        _remote.fetchSalesProfile(userId),
        _remote.fetchWholesalerProfile(userId),
      ]);
      final salesRow = rows[0];
      final wholesalerRow = rows[1];

      if (salesRow != null && salesRow['status'] == 'active') {
        return Success(B2bRoleResolution.salesman(_toSalesProfile(salesRow)));
      }
      if (wholesalerRow != null && wholesalerRow['status'] == 'active') {
        return Success(B2bRoleResolution.wholesaler(_toWholesalerProfile(wholesalerRow)));
      }
      return const Success(B2bRoleResolution.customer());
    } on PostgrestException catch (e) {
      return Failed(NetworkFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<WholesalerProfile>>> getAssignedWholesalers(String salesId) async {
    try {
      final rows = await _remote.fetchAssignedWholesalers(salesId);
      return Success(rows.map(_toWholesalerProfile).toList());
    } on PostgrestException catch (e) {
      return Failed(NetworkFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  SalesProfile _toSalesProfile(Map<String, dynamic> row) {
    return SalesProfile(
      id: row['id'] as String,
      fullName: row['full_name'] as String? ?? '',
      phone: row['phone'] as String? ?? '',
      email: row['email'] as String? ?? '',
      status: row['status'] as String? ?? 'active',
      createdBy: row['created_by'] as String? ?? '',
    );
  }

  WholesalerProfile _toWholesalerProfile(Map<String, dynamic> row) {
    return WholesalerProfile(
      id: row['id'] as String,
      fullName: row['full_name'] as String? ?? '',
      businessName: row['business_name'] as String?,
      phone: row['phone'] as String? ?? '',
      email: row['email'] as String? ?? '',
      gstNumber: row['gst_number'] as String?,
      status: row['status'] as String? ?? 'active',
      assignedSalesId: row['assigned_sales_id'] as String?,
      createdBy: row['created_by'] as String? ?? '',
      createdByRole: row['created_by_role'] as String? ?? 'admin',
      address: row['address'] as Map<String, dynamic>?,
    );
  }
}
