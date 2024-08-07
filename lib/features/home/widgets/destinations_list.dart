import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/destinations/cubit/article_cubit.dart';
import 'package:guardowl/features/destinations/models/destinations_score_model.dart';

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
      return Center(
        child: CircularProgressIndicator(color: color.secondary),
      );
    } else if (stateDestination.status is EmptyState) {
      return Center(
        child: Text('There are no items available.', style: textError),
      );
    } else if (stateDestination.status is LoadedState) {
      final destinations = stateDestination.destinations;

      return SizedBox(
        width: width,
        height: height,
        child: GridView.builder(
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: destinations.length,
          itemBuilder: (BuildContext context, int index) {
            final destination = destinations[index];
            return _PhotoListItem(destination: destination);
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
    return currentScroll >= (maxScroll * 0.9);
  }
}

class _PhotoListItem extends StatelessWidget {
  final DestinationsScore destination;
  const _PhotoListItem({required this.destination});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 109,
        height: 95,
        decoration: BoxDecoration(
          color: color.secondary,
          image: DecorationImage(
            image: NetworkImage(destination.photoUrl),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
