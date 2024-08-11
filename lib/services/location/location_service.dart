import 'package:fpdart/fpdart.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../core/failures.dart';

class LocationService {
  const LocationService();

  Future<Either<Failure, (double, double)>> getLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return left(const NetworkFailure('Location services are disabled'));
      }

      final permission = await _checkPermission();

      if (permission == LocationPermission.denied) {
        return left(const NetworkFailure('Location permissions are denied'));
      }
      if (permission == LocationPermission.deniedForever) {
        return left(const NetworkFailure(
            'Location permissions are permanently denied, we cannot request permissions.'));
      }
      final position = await Geolocator.getCurrentPosition();

      return right((position.latitude, position.longitude));
    } catch (e) {
      return left(UnknowFailure('An unknown error occurred $e'));
    }
  }

  Future<LocationPermission> _checkPermission() async {
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      return Geolocator.requestPermission();
    }
    return permission;
  }

  Stream<Either<Failure, (double, double)>> getLocationStream() {
    return Geolocator.getPositionStream().map((position) {
      return right((position.latitude, position.longitude));
    });
  }

  Future<Either<Failure, String>> getAddressFromLocation(
      double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      final placemark = placemarks.firstOrNull;

      if (placemark == null) return right('No address found');

      final address = '${placemark.street}, ${placemark.locality}';

      return right(address);
    } catch (e) {
      return left(UnknowFailure('An unknown error occurred $e'));
    }
  }
}
