import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardowl/constants/constants.dart';
import 'package:guardowl/features/destinations/models/destinations_score_model.dart';
part 'destinations_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
  DestinationCubit()
      : super(
          DestinationState(
            destinations: const [],
            favorites: const [],
            hasReachedMax: false,
            status: InitialLoadingState(),
          ),
        ) {
    _loadArticlesFromFile(jsonDestinationsHeight);
  }

  void _markAsLoaded(List<DestinationsScore> destinations) {
    emit(DestinationState(
      destinations: destinations,
      favorites: const [],
      hasReachedMax: destinations.length <
          10, // Asume que si menos de 10 items, alcanzó el máximo.
      status: LoadedState(destinations: destinations),
    ));
  }

  void _loadArticlesFromFile(String filePath) async {
    emit(
      DestinationState(
        destinations: const [],
        favorites: const [],
        hasReachedMax: false,
        status: InitialLoadingState(),
      ),
    );
    try {
      String jsonString = await rootBundle.loadString(filePath);
      List<DestinationsScore> destinations =
          destinationsScoreFromJson(jsonString);

      if (destinations.isNotEmpty) {
        _markAsLoaded(destinations);
      } else {
        emit(
          DestinationState(
            destinations: const [],
            favorites: const [],
            hasReachedMax: true,
            status: EmptyState(),
          ),
        );
      }
    } catch (e) {
      emit(
        DestinationState(
          destinations: const [],
           favorites: const [],
          hasReachedMax: true,
          status: ErrorState(error: e.toString()),
        ),
      );
    }
  }

  void loadMoreDestinations() async {
    if (state.hasReachedMax) return;

    try {
      String jsonString = await rootBundle.loadString(jsonDestinationsHeight);
      List<DestinationsScore> moreDestinations =
          destinationsScoreFromJson(jsonString);

      emit(
        state.copyWith(
          destinations: List.of(state.destinations)..addAll(moreDestinations),
          hasReachedMax: moreDestinations.isEmpty,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ErrorState(error: e.toString()),
        ),
      );
    }
  }

  void addFavorite(DestinationsScore destination) {
    final updatedFavorites = List<DestinationsScore>.from(state.favorites)
      ..add(destination);
    emit(state.copyWith(favorites: updatedFavorites));
  }

  void removeFavorite(DestinationsScore destination) {
    final updatedFavorites = List<DestinationsScore>.from(state.favorites)
      ..remove(destination);
    emit(state.copyWith(favorites: updatedFavorites));
  }
}
