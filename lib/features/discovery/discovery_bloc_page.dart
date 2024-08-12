import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/discovery/navigation_search/bloc/navigation_search_bloc.dart';
import 'package:guardowl/features/discovery/views/error_map_view.dart';
import 'package:guardowl/features/discovery/widgets/lenged_indicators.dart';
import 'package:guardowl/features/discovery/widgets/search_container_button.dart';
import 'package:guardowl/features/share/loader_custom.dart';
import 'package:guardowl/features/share/sos_button.dart';
import 'bloc/location_bloc.dart';
import 'views/map_view.dart';

class DiscoveryView extends StatefulWidget {
  final VoidCallback onInit;
  final VoidCallback onDispose;

  const DiscoveryView(
      {super.key, required this.onInit, required this.onDispose});

  @override
  State<DiscoveryView> createState() => _DiscoveryViewState();
}

class _DiscoveryViewState extends State<DiscoveryView> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // MapView here:
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: BlocBuilder<LocationBloc, LocationState>(
              buildWhen: (previous, current) => previous is LocationLoading,
              builder: (context, state) {
                return switch (state) {
                  LocationLoading() => const Center(
                      child: BottomLoader(),
                    ),
                  LocationFailure(:final failure) =>
                    ErrorMapView(failure: failure),
                  LocationSuccess(:final location, :final locationZones) =>
                    MapView(
                      initialLocation: location,
                      locationZones: locationZones,
                    ),
                };
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                      child: BlocSelector<NavigationSearchBloc,
                          NavigationSearchState, bool>(
                    selector: (state) {
                      return state.originState.isSelectingCoordinates ||
                          state.destinationState.isSelectingCoordinates;
                    },
                    builder: (context, state) {
                      if (state) {
                        return const SearchSelectingCard();
                      }
                      return SearchContainerButton(
                        onPressed: () {
                          context
                              .read<NavigationSearchBloc>()
                              .add(const ChangeShowRoute(false));
                          if (context.read<LocationBloc>().state
                              case LocationSuccess success) {
                            final originState = context
                                .read<NavigationSearchBloc>()
                                .state
                                .originState;

                            if (originState is LocationSearchInitial) {
                              context
                                  .read<NavigationSearchBloc>()
                                  .add(LoadOriginCoordinates(success.location));
                            }
                          }
                        },
                      );
                    },
                  )),
                  const SizedBox(width: 10),
                  const SosButton(),
                  const SizedBox(width: 10),
                ],
              ),
              const Spacer(),
              const LengedIndicators(),
            ],
          ),
        ],
      ),
    );
  }
}
