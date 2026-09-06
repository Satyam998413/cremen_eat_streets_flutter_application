import '../error/result.dart';

/// Every use case in the app implements this — one action, one call() method.
abstract class UseCase<R, Params> {
  Future<Result<R>> call(Params params);
}

/// For use cases that need no input.
class NoParams {
  const NoParams();
}
