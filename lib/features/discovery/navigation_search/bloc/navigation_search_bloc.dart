import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardowl/services/location/location_service.dart';
import 'package:guardowl/services/location/location_zone_model.dart';

part 'navigation_search_event.dart';
part 'navigation_search_state.dart';

class NavigationSearchBloc
    extends Bloc<NavigationSearchEvent, NavigationSearchState> {
  final _locationService = const LocationService();

  NavigationSearchBloc() : super(NavigationSearchState.initial()) {
    on<LoadOriginCoordinates>(_onLoadOriginCoordinates);
    on<LoadDestinationCoordinates>(_onLoadDestinationCoordinates);
    on<SelectOriginCoordinates>(_onSelectOriginCoordinates);
    on<SelectDestinationCoordinates>(_onSelectDestinationCoordinates);
    on<ChangeShowRoute>(_onChangeShowRoute);
  }

  void _onLoadOriginCoordinates(
    LoadOriginCoordinates event,
    Emitter<NavigationSearchState> emit,
  ) async {
    emit(state.copyWith(originState: LocationSearchLoading()));

    final (double latitude, double longitude) = event.coordinates;
    final res =
        await _locationService.getAddressFromLocation(latitude, longitude);

    final address = res.fold(
      (failure) => event.coordinates.toString(),
      (location) => location,
    );

    emit(state.copyWith(
        originState: LocationSearchSuccess(event.coordinates, address)));
  }

  void _onLoadDestinationCoordinates(
    LoadDestinationCoordinates event,
    Emitter<NavigationSearchState> emit,
  ) async {
    emit(state.copyWith(destinationState: LocationSearchLoading()));

    final (double latitude, double longitude) = event.coordinates;
    final res =
        await _locationService.getAddressFromLocation(latitude, longitude);

    final address = res.fold(
      (failure) => event.coordinates.toString(),
      (location) => location,
    );

    emit(state.copyWith(
        destinationState: LocationSearchSuccess(event.coordinates, address)));
  }

  void _onSelectDestinationCoordinates(
    SelectDestinationCoordinates event,
    Emitter<NavigationSearchState> emit,
  ) {
    emit(state.copyWith(destinationState: LocationSearchSelecting()));
  }

  void _onSelectOriginCoordinates(
    SelectOriginCoordinates event,
    Emitter<NavigationSearchState> emit,
  ) {
    emit(state.copyWith(originState: LocationSearchSelecting()));
  }

  void _onChangeShowRoute(
    ChangeShowRoute event,
    Emitter<NavigationSearchState> emit,
  ) {
    emit(state.copyWith(showRoute: event.showRoute));
  }
}
