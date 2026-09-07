import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/resolved_address.dart';
import '../repositories/checkout_repository.dart';

class ReverseGeocodeParams {
  const ReverseGeocodeParams({required this.lat, required this.lon});

  final double lat;
  final double lon;
}

class ReverseGeocodeUseCase implements UseCase<ResolvedAddress, ReverseGeocodeParams> {
  const ReverseGeocodeUseCase(this._repository);

  final CheckoutRepository _repository;

  @override
  Future<Result<ResolvedAddress>> call(ReverseGeocodeParams params) {
    return _repository.reverseGeocode(lat: params.lat, lon: params.lon);
  }
}
