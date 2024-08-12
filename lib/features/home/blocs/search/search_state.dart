part of 'search_cubit.dart';

class SearchState extends Equatable {
  final String? destination;

  const SearchState({this.destination});

  SearchState copyWith({
    String? destination,
  }) {
    return SearchState(
      destination: destination ?? this.destination, 
    );
  }

  @override
  List<Object?> get props => [destination];
}

sealed class StatusSearch {}

class SearchInitial extends StatusSearch {}

class SearchDestination extends StatusSearch {}
