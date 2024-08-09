part of 'location_bloc.dart';

sealed class LocationState {
  const LocationState();
}

final class LocationLoading extends LocationState {
  const LocationLoading();
}

final class LocationSuccess extends LocationState {
  final (double latitude, double longitude) location;
  final List<LocationZone> locationZones;

  const LocationSuccess(
    this.location, {
    this.locationZones = const [],
  });
}

final class LocationFailure extends LocationState {
  final Failure failure;

  const LocationFailure(this.failure);
}
