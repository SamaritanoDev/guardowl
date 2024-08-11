part of 'navigation_search_bloc.dart';

class NavigationSearchState extends Equatable {
  final LocationSearchState originState;
  final LocationSearchState destinationState;
  final bool showRoute;

  const NavigationSearchState(
      this.originState, this.destinationState, this.showRoute);

  @override
  List<Object> get props => [originState, destinationState, showRoute];

  factory NavigationSearchState.initial() {
    return NavigationSearchState(
      LocationSearchInitial(),
      LocationSearchInitial(),
      false,
    );
  }

  NavigationSearchState copyWith({
    LocationSearchState? originState,
    LocationSearchState? destinationState,
    bool? showRoute,
  }) {
    return NavigationSearchState(
      originState ?? this.originState,
      destinationState ?? this.destinationState,
      showRoute ?? this.showRoute,
    );
  }

  bool get isEnablingNavigation =>
      originState is LocationSearchSuccess &&
      destinationState is LocationSearchSuccess;

  LocationZone? get originZone {
    if (originState is LocationSearchSelecting) {
      return null;
    }

    if (originState case LocationSearchSuccess success) {
      final (double latitude, double longitude) = success.coordinates;
      return LocationZone(
        id: 'origin',
        title: 'Current Ubication',
        riskGroup: success.address,
        riskSegment: 'ROUTE',
        latitude: latitude,
        longitude: longitude,
      );
    }
    return null;
  }

  LocationZone? get destinationZone {
    if (destinationState is LocationSearchSelecting) {
      return null;
    }
    if (destinationState case LocationSearchSuccess success) {
      final (double latitude, double longitude) = success.coordinates;
      return LocationZone(
        id: 'destination',
        title: 'Destination',
        riskGroup: 'ROUTE',
        riskSegment: success.address,
        latitude: latitude,
        longitude: longitude,
      );
    }
    return null;
  }
}

sealed class LocationSearchState extends Equatable {
  const LocationSearchState();

  @override
  List<Object> get props => [];

  bool get isSelectingCoordinates => this is LocationSearchSelecting;
}

class LocationSearchLoading extends LocationSearchState {}

class LocationSearchInitial extends LocationSearchState {}

class LocationSearchSelecting extends LocationSearchState {}

class LocationSearchSuccess extends LocationSearchState {
  final (double latitude, double longitude) coordinates;
  final String address;

  const LocationSearchSuccess(this.coordinates, this.address);

  @override
  List<Object> get props => [coordinates, address];
}
