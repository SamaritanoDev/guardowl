part of 'navigation_search_bloc.dart';

sealed class NavigationSearchEvent extends Equatable {
  const NavigationSearchEvent();

  @override
  List<Object> get props => [];
}

class LoadOriginCoordinates extends NavigationSearchEvent {
  final (double latitude, double longitude) coordinates;

  const LoadOriginCoordinates(this.coordinates);

  @override
  List<Object> get props => [coordinates];
}

class LoadDestinationCoordinates extends NavigationSearchEvent {
  final (double latitude, double longitude) coordinates;

  const LoadDestinationCoordinates(this.coordinates);

  @override
  List<Object> get props => [coordinates];
}

class SelectOriginCoordinates extends NavigationSearchEvent {
  const SelectOriginCoordinates();
}

class SelectDestinationCoordinates extends NavigationSearchEvent {
  const SelectDestinationCoordinates();
}

class ChangeShowRoute extends NavigationSearchEvent {
  final bool showRoute;

  const ChangeShowRoute(this.showRoute);

  @override
  List<Object> get props => [showRoute];
}
