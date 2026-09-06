import 'failure.dart';

/// App-owned `Result<T>` — every repository method returns this, never a raw
/// exception. Dart 3 sealed classes give exhaustive `switch` without pulling
/// in a functional-programming package the whole team would need to learn.
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

class Failed<T> extends Result<T> {
  const Failed(this.failure);

  final Failure failure;
}
