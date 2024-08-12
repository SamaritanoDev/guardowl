import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/destinations/cubit/destinations_cubit.dart';
import 'package:guardowl/features/destinations/models/destinations_score_model.dart';
import 'package:guardowl/utils/snackbar_alert.dart';

class PhotoListItem extends StatelessWidget {
  final DestinationsScore destination;
  const PhotoListItem({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textTitleCard = textTheme.titleSmall?.copyWith(
      color: color.inversePrimary,
    );

    final readDestinationCubit = context.read<DestinationCubit>();
    final isFavorite = context.watch<DestinationCubit>().state.favorites.contains(destination);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/route-assistant',
          arguments: destination.title,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Image.network(
              destination.photoUrl,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.4),
              colorBlendMode: BlendMode.darken,
            ),
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                onPressed: () {
                  if (isFavorite) {
                    readDestinationCubit.removeFavorite(destination);
                  } else {
                    readDestinationCubit.addFavorite(destination);
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBarNewFavouriteItem(color: color.primary),
                    );
                  }
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,
                  color: color.tertiary,
                  size: 30,
                ),
              ),
            ),
            Positioned(
              left: 12,
              bottom: 13,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text(
                          destination.title,
                          style: textTitleCard,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      const SizedBox(height: 5),
                      _BotomPhoto(destination),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BotomPhoto extends StatelessWidget {
  final DestinationsScore destination;
  const _BotomPhoto(this.destination);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    final textSubTitleCard = textTheme.bodySmall?.copyWith(color: color.onPrimary);

    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: color.onPrimary,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              destination.dptoPjfs.toUpperCase(),
              style: textSubTitleCard,
            ),
            Text(
              destination.provPjfs.toUpperCase(),
              style: textSubTitleCard,
            ),
          ],
        ),
      ],
    );
  }
}
