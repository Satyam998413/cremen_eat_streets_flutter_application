import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Thin wrapper around the Supabase calls this feature needs. Throws
/// PostgrestException — mapping it to a typed Failure is the repository's
/// job, matching the pattern of every other *RemoteDataSource in this app
/// (see auth_remote_datasource.dart, catalog_remote_datasource.dart).
@lazySingleton
class B2bRemoteDataSource {
  B2bRemoteDataSource(this._client);

  final SupabaseClient _client;

  /// Self-read only — `sales_profiles` RLS only allows `id = auth.uid()`.
  Future<Map<String, dynamic>?> fetchSalesProfile(String userId) {
    return _client.from('sales_profiles').select().eq('id', userId).maybeSingle();
  }

  /// Self-read only — `wholesaler_profiles` RLS allows `id = auth.uid()`.
  Future<Map<String, dynamic>?> fetchWholesalerProfile(String userId) {
    return _client.from('wholesaler_profiles').select().eq('id', userId).maybeSingle();
  }

  /// A salesman's own active wholesalers — allowed directly under
  /// `wholesaler_profiles`' "own salesman read" RLS policy
  /// (`assigned_sales_id = auth.uid()`), no bespoke backend endpoint needed.
  Future<List<Map<String, dynamic>>> fetchAssignedWholesalers(String salesId) async {
    final rows = await _client
        .from('wholesaler_profiles')
        .select()
        .eq('assigned_sales_id', salesId)
        .eq('status', 'active')
        .order('full_name');
    return List<Map<String, dynamic>>.from(rows as List);
  }
}
