import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/destinations/cubit/destinations_cubit.dart';
import 'package:guardowl/features/share/loader_custom.dart';
import 'package:guardowl/features/share/photo_item_list.dart';

class DestinationsList extends StatelessWidget {
  const DestinationsList({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final stateDestination = context.watch<DestinationCubit>().state;
    final textError = textTheme.bodyLarge?.copyWith(
      color: color.error,
      fontWeight: FontWeight.bold,
    );
    // final media = MediaQuery.of(context);
    // final width = media.size.width;
    // final height = media.size.height;

    if (stateDestination.status is InitialLoadingState) {
      return const Center(
        child: BottomLoader(),
      ).boxAdapter;
    } else if (stateDestination.status is EmptyState) {
      return Center(
        child: Text('There are no items available.', style: textError),
      ).boxAdapter;
    } else if (stateDestination.status is LoadedState) {
      final destinations = stateDestination.destinations;

      return SliverGrid.builder(
          itemCount: destinations.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            final destination = destinations[index];
            return PhotoListItem(destination: destination);
          });
    } else {
      return Center(
        child: Text(
          'Error loading destinations.',
          style: textError,
        ),
      ).boxAdapter;
    }
  }
}

extension BoxAdapter on Widget {
  Widget get boxAdapter => SliverToBoxAdapter(child: this);
}
