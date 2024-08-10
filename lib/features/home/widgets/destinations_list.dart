import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/destinations/cubit/destinations_cubit.dart';
import 'package:guardowl/features/share/loader_custom.dart';
import 'package:guardowl/features/share/photo_item_list.dart';

class DestinationsList extends StatefulWidget {
  const DestinationsList({super.key});

  @override
  State<DestinationsList> createState() => _DestinationsListState();
}

class _DestinationsListState extends State<DestinationsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final stateDestination = context.watch<DestinationCubit>().state;
    final textError = textTheme.bodyLarge?.copyWith(
      color: color.error,
      fontWeight: FontWeight.bold,
    );
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    if (stateDestination.status is InitialLoadingState) {
      return const Center(
        child: BottomLoader(),
      );
    } else if (stateDestination.status is EmptyState) {
      return Center(
        child: Text('There are no items available.', style: textError),
      );
    } else if (stateDestination.status is LoadedState) {
      print("Loaded destinations: ${stateDestination.destinations.length}");

      final destinations = stateDestination.destinations;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: width,
        height: height,
        child: GridView.builder(
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: destinations.length,
          itemBuilder: (BuildContext context, int index) {
            final destination = destinations[index];
            return PhotoListItem(destination: destination);
          },
        ),
      );
    } else {
      return Center(
        child: Text(
          'Error loading destinations.',
          style: textError,
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<DestinationCubit>().loadMoreDestinations();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.5);
  }
}
