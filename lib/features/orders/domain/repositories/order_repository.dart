import '../../../../core/error/result.dart';
import '../entities/food_order.dart';

abstract class OrderRepository {
  /// RLS-scoped to `user_id = auth.uid()` — empty for a guest (not logged
  /// in), by design: guests have no "my orders" list, only their one
  /// receipt link (see [getByPublicToken]).
  Future<Result<List<FoodOrder>>> getHistory();

  /// Works for both guest and logged-in orders — the public_token is the
  /// same "anyone holding this link can see the receipt" key the website's
  /// own /order/[publicToken] page uses, exposed here via a narrowly-scoped
  /// RPC instead of a service-role server fetch (see
  /// order_remote_datasource.dart for why a mobile client needs this).
  Future<Result<FoodOrder>> getByPublicToken(String publicToken);
}
