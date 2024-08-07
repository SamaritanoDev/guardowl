import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardowl/constants/constants.dart';
import 'package:guardowl/features/destinations/models/destinations_score_model.dart';
part 'article_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
  DestinationCubit()
      : super(
          DestinationState(
            status: InitialLoadingState(),
          ),
        ) {
    _loadArticlesFromFile(jsonDestinationsHeight);
  }

  void _markAsLoaded(List<DestinationsScore> destinations) {
    emit(DestinationState(
      status: LoadedState(destinations: destinations),
    ));
  }

  void _loadArticlesFromFile(String filePath) async {
    emit(
      DestinationState(
        status: InitialLoadingState(),
      ),
    );
    try {
      String jsonString = await rootBundle.loadString(filePath);

      List<DestinationsScore> destinations = destinationsScoreFromJson(jsonString);

      if (destinations.isNotEmpty) {
        _markAsLoaded(destinations);
      } else {
        emit(
          DestinationState(
            status: EmptyState(),
          ),
        );
      }
    } catch (e) {
      emit(
        DestinationState(
          status: ErrorState(error: e.toString()),
        ),
      );
    }
  }
}
