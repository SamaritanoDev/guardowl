import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:guardowl/services/location/location_zone_model.dart';
import 'package:guardowl/services/location/markers_service.dart';
import '../../../services/core/failures.dart';
import '../../../services/location/location_service.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final _locationService = const LocationService();
  final MarkersService _markersService = const MarkersServiceAssetImpl();

  LocationBloc() : super(const LocationLoading()) {
    on<LocationRequested>(_onLocationRequested);
    on<LoadLocationZones>(_onLoadLocationZones);
    on<LocationStreamRequested>(onLocationStreamRequested,
        transformer: restartable());
  }

  void _onLoadLocationZones(
    LoadLocationZones event,
    Emitter<LocationState> emit,
  ) async {
    final res = await _markersService.getMarkers();

    emit(LocationSuccess(
      event.location,
      locationZones: res.getOrElse((_) => []),
    ));
  }

  void _onLocationRequested(
    LocationRequested event,
    Emitter<LocationState> emit,
  ) async {
    emit(const LocationLoading());

    final res = await _locationService.getLocation();

    (res.fold(
      (failure) => emit(LocationFailure(failure)),
      (location) => add(LoadLocationZones(location)),
    ));

    if (res.isLeft()) return;
    add(const LocationStreamRequestedOpen());
  }

  Future<void> onLocationStreamRequested(
    LocationStreamRequested event,
    Emitter<LocationState> emit,
  ) async {
    if (state is LocationLoading) return;

    if (event case LocationStreamRequestedOpen _) {
      await Future.delayed(const Duration(seconds: 1));

      await emit.forEach(
        _locationService.getLocationStream(),
        onData: (res) => res.fold(
          LocationFailure.new,
          (location) => LocationSuccess(
            location,
            locationZones: switch (state) {
              LocationSuccess(:final locationZones) => locationZones,
              _ => const [],
            },
          ),
        ),
      );
    }
  }
}
