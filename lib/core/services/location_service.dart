import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import '../error/failure.dart';
import '../error/result.dart';

/// Wraps geolocator's own permission flow — no separate permission_handler
/// dependency needed, geolocator already exposes checkPermission/
/// requestPermission and triggers the native OS prompt itself.
@lazySingleton
class LocationService {
  const LocationService();

  Future<Result<Position>> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const Failed(ValidationFailure('Please enable location services to use this feature.'));
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      return const Failed(ValidationFailure('Location permission was denied.'));
    }
    if (permission == LocationPermission.deniedForever) {
      return const Failed(
        ValidationFailure('Location permission is permanently denied — enable it from your device settings.'),
      );
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 12),
        ),
      );
      return Success(position);
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }
}
