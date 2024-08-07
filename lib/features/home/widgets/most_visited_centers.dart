import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/constants/enviroments_search_view.dart';
import 'package:guardowl/features/destinations/cubit/article_cubit.dart';
import 'package:guardowl/features/home/widgets/my_card_image.dart';

class MostVisitedCenters extends StatelessWidget {
  const MostVisitedCenters({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final textTitleLargePrimary = textTheme.titleLarge?.copyWith(
      color: color.primary,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    final textError = textTheme.bodyLarge?.copyWith(
      color: color.error,
      fontWeight: FontWeight.bold,
    );

    final stateDestination = context.watch<DestinationCubit>().state;

    if (stateDestination  is InitialLoadingState) {
      return Center(
        child: CircularProgressIndicator(color: color.secondary),
      );
    } else if (stateDestination  is EmptyState) {
      return Center(
        child: Text(
          'No hay artículos disponibles.',
          style: textTitleLargePrimary,
        ),
      );
    } else if (stateDestination.status is LoadedState) {
      final loadedState = stateDestination.status as LoadedState;
      final destinationsHeight = loadedState.destinations;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: paddingAppBar),
            child: Text(
              "Destinations you must visit",
              style: textTitleLargePrimary,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: heightCardImage,
            width: width,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: paddingAppBar),
              itemCount: destinationsHeight.length,
              scrollDirection: Axis.horizontal,
              itemExtent: widthCardImage,
              itemBuilder: (BuildContext context, int index) {
                final destination = destinationsHeight[index];

                return MyCardImage(
                  urlImage: destination.photoUrl,
                  titleDestination: destination.title,
                  location: destination.dptoPjfs,
                  place: destination.distPjfs,
                );
              },
            ),
          ),
        ],
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
}
