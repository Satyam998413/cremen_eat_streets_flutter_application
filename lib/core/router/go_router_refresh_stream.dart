import 'dart:async';
import 'package:flutter/foundation.dart';

/// Turns a Stream into a Listenable go_router's `refreshListenable` can use,
/// so a `redirect:` callback re-evaluates every time the given stream emits
/// (here, every AuthBloc state change) instead of only on navigation.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
