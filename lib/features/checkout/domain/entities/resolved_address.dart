import 'package:equatable/equatable.dart';

/// Result of reverse-geocoding a lat/lng via the website's own
/// `/api/geocode/reverse` proxy (OpenStreetMap Nominatim — see
/// LocationPicker.jsx, cremen_eat_streets).
class ResolvedAddress extends Equatable {
  const ResolvedAddress({
    required this.line1,
    required this.city,
    required this.state,
    required this.pincode,
    required this.displayName,
  });

  final String line1;
  final String city;
  final String state;
  final String pincode;
  final String displayName;

  @override
  List<Object?> get props => [line1, city, state, pincode, displayName];
}
