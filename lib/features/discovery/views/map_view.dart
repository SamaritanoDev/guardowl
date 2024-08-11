import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guardowl/features/discovery/bloc/location_bloc.dart';
import 'package:guardowl/features/discovery/navigation_search/bloc/navigation_search_bloc.dart';
import 'package:guardowl/features/discovery/navigation_search/navigation_search_view.dart';
import 'package:guardowl/services/location/location_zone_model.dart';

class MapView extends StatefulWidget {
  final (double latitude, double longitude) initialLocation;
  final List<LocationZone> locationZones;

  const MapView({
    super.key,
    required this.initialLocation,
    required this.locationZones,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late BitmapDescriptor customIconLow;
  late BitmapDescriptor customIconMedium;
  late BitmapDescriptor customIconHigh;

  void setCustomMarker() async {
    customIconMedium = await BitmapDescriptor.asset(const ImageConfiguration(),
        'assets/icons/markers_for_map/medium_score.png');
    customIconHigh = await BitmapDescriptor.asset(const ImageConfiguration(),
        'assets/icons/markers_for_map/high_score.png');
    customIconLow = await BitmapDescriptor.asset(const ImageConfiguration(),
        'assets/icons/markers_for_map/good_score.png');

    _isIconLoaded = true;
    setState(() {});
  }

  bool _isIconLoaded = false;

  @override
  void initState() {
    setCustomMarker();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    if (_isIconLoaded == false) {
      return const SizedBox.shrink();
    }
    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state case LocationSuccess _) {
          /*   _controller?.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(success.location.$1, success.location.$2),
              zoom: 14.4746,
            ),
          )); */
        }
      },
      child: BlocSelector<NavigationSearchBloc, NavigationSearchState,
          List<LocationZone>>(
        selector: (state) {
          if (!state.showRoute) {
            return [];
          }
          return [
            if (state.originZone != null) state.originZone!,
            if (state.destinationZone != null) state.destinationZone!,
          ];
        },
        builder: (context, state) {
          return GoogleMap(
            markers: [...state, ...widget.locationZones].map((zone) {
              return Marker(
                markerId: MarkerId(zone.id),
                icon: switch (zone.riskSegmentEnum) {
                  RiskSegment.low => customIconLow,
                  RiskSegment.medium => customIconMedium,
                  RiskSegment.high => customIconHigh,
                  RiskSegment.route => BitmapDescriptor.defaultMarker,
                },
                position: LatLng(zone.latitude, zone.longitude),
                infoWindow:
                    InfoWindow(title: zone.title, snippet: zone.riskGroup),
              );
            }).toSet(),
            mapType: MapType.normal,
            myLocationEnabled: true,
            onTap: (argument) {
              final state = context.read<NavigationSearchBloc>().state;

              if (state.originState.isSelectingCoordinates) {
                context.read<NavigationSearchBloc>().add(
                      LoadOriginCoordinates(
                        (argument.latitude, argument.longitude),
                      ),
                    );
              } else if (state.destinationState.isSelectingCoordinates) {
                context.read<NavigationSearchBloc>().add(
                      LoadDestinationCoordinates(
                        (argument.latitude, argument.longitude),
                      ),
                    );
              }
              if (state.originState.isSelectingCoordinates ||
                  state.destinationState.isSelectingCoordinates) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NavigationSearchView(),
                  ),
                );
              }
            },
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(widget.initialLocation.$1, widget.initialLocation.$2),
              zoom: 10,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          );
        },
      ),
    );
  }
}
