part of 'article_cubit.dart';

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
  final StateDestination status;
  final List<DestinationsScore> destinations;
  const DestinationState({
    required this.status,
    this.destinations = const [],
  });

  bool get isInitialLoading => status == InitialLoadingState();

  bool get isEmpty => status == EmptyState();

  DestinationState copyWith({
    StateDestination? status,
    List<DestinationsScore>? destinations,
    int? countdestinations,
  }) =>
      DestinationState(
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [status, destinations];
}
