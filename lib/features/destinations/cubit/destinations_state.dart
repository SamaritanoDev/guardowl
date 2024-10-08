part of 'destinations_cubit.dart';

sealed class StateDestination {
  const StateDestination();
}

class InitialLoadingState extends StateDestination {}

class LoadedState extends StateDestination {
  final List<DestinationsScore> destinations;
  LoadedState({
    required this.destinations,
  });
}

class ErrorState extends StateDestination {
  final Object error;

  ErrorState({required this.error});
}

class EmptyState extends StateDestination {}

class DestinationState extends Equatable {
  final List<DestinationsScore> destinations;
  final List<DestinationsScore> favorites;
  final bool hasReachedMax;
  final StateDestination status;

  const DestinationState({
    required this.destinations,
    required this.favorites,
    required this.hasReachedMax,
    required this.status,
  });

  DestinationState copyWith({
    List<DestinationsScore>? destinations,
    List<DestinationsScore>? favorites,
    bool? hasReachedMax,
    StateDestination? status,
  }) {
    return DestinationState(
      destinations: destinations ?? this.destinations,
       favorites: favorites ?? this.favorites,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [destinations, favorites, hasReachedMax, status];
}
