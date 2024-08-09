import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:guardowl/services/core/failures.dart';
import 'package:guardowl/services/location/location_zone_model.dart';

abstract class MarkersService {
  Future<Either<Failure, List<LocationZone>>> getMarkers();
}

class MarkersServiceAssetImpl implements MarkersService {
  static const dataKey = 'lib/services/location/locations_zone_data.json';
  const MarkersServiceAssetImpl();

  @override
  Future<Either<Failure, List<LocationZone>>> getMarkers() async {
    try {
      final jsonString = await rootBundle.loadString(dataKey);

      final markers = locationZoneFromJson(jsonString);

      return right(markers);
    } catch (e) {
      return left(UnknowFailure('An unknown error occurred $e'));
    }
  }
}
