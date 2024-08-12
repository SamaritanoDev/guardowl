import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
 SearchCubit() : super(const SearchState());

  void setDestination(String destination) {
    emit(state.copyWith(destination: destination));
  }

  void clearDestination() {
    emit(const SearchState());
  }
}
