part of 'location_bloc.dart';

sealed class LocationEvent {
  const LocationEvent();
}

final class LocationRequested extends LocationEvent {
  const LocationRequested();
}

sealed class LocationStreamRequested extends LocationEvent {
  const LocationStreamRequested();
}

final class LocationStreamRequestedOpen extends LocationStreamRequested {
  const LocationStreamRequestedOpen();
}

final class LocationStreamRequestedClose extends LocationStreamRequested {
  const LocationStreamRequestedClose();
}

final class LoadLocationZones extends LocationEvent {
  const LoadLocationZones();
}
