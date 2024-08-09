import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/discovery/views/error_map_view.dart';
import 'package:guardowl/features/discovery/widgets/search_container_button.dart';
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
                      child: CircularProgressIndicator(),
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
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 20),
                  Expanded(child: SearchContainerButton()),
                  SizedBox(width: 10),
                  SosButton(),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
