import 'package:supabase_flutter/supabase_flutter.dart';

const _orderSelect = 'id, public_token, order_number, status, fulfillment_type, customer_name, '
    'customer_phone, customer_email, shipping_address, notes, subtotal, shipping_fee, total, created_at, '
    'order_items(id, product_id, product_name, variant_label, unit_price, quantity, line_total)';

/// Thin wrapper around the Supabase calls this feature needs. Throws
/// PostgrestException — mapping it to a typed Failure is the repository's job.
class OrderRemoteDataSource {
  OrderRemoteDataSource(this._client);

  final SupabaseClient _client;

  /// RLS ("customer read own", user_id = auth.uid()) scopes this — a guest
  /// (anon) call returns an empty list, since there is no anon read policy
  /// on `orders` at all.
  Future<List<Map<String, dynamic>>> fetchHistory() async {
    final rows = await _client.from('orders').select(_orderSelect).order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(rows as List);
  }

  /// Requires the `get_order_by_public_token(p_public_token)` RPC from
  /// supabase/migrations/016_mobile_order_lookup.sql (cremen_eat_streets) —
  /// NOT YET applied to the live project as of this writing. `orders` has no
  /// RLS policy letting anon (or even a logged-in customer who doesn't own
  /// the row, e.g. viewing their own guest-placed order before claiming it)
  /// read by public_token directly — the website's own equivalent page
  /// works around this with a server-side service-role fetch, which a
  /// mobile client can never hold; this RPC is the narrowly-scoped
  /// (SECURITY DEFINER, matches only the exact token) equivalent for it.
  Future<Map<String, dynamic>?> fetchByPublicToken(String publicToken) async {
    final result = await _client.rpc('get_order_by_public_token', params: {'p_public_token': publicToken});
    if (result == null) return null;
    return Map<String, dynamic>.from(result as Map);
  }
}
