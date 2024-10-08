import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_search_view.dart';

class LocationMarkerData extends StatelessWidget {
  const LocationMarkerData({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    final textTheme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final textTitleLargeAlert = textTheme.titleLarge?.copyWith(
      color: color.primary,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15.13),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingAppBar),
          child: Text(
            "Avoid transiting through these areas",
            style: textTitleLargeAlert,
          ),
        ),
        SizedBox(
          width: width,
          child: const Column(
            children: [
              _ListTileLocationMarker(
                namePlace: "Mall of Indonesia",
                nameLocation: "Kelapa Gading, Jakarta Utara",
                distanceToLocation: "1.2 km",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ListTileLocationMarker extends StatelessWidget {
  final String namePlace;
  final String nameLocation;
  final String distanceToLocation;

  const _ListTileLocationMarker({
    required this.namePlace,
    required this.nameLocation,
    required this.distanceToLocation,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textBodySmallError =
        textTheme.bodySmall?.copyWith(color: color.secondary);

    return ListTile(
      leading: CustomCard(
        child: Icon(
          Icons.location_on,
          color: color.secondary,
        ),
      ),
      iconColor: color.primary,
      title: Text(namePlace, style: textTheme.titleMedium),
      subtitle: Text(nameLocation, style: textBodySmallError),
      trailing: Text(distanceToLocation, style: textBodySmallError),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Widget child;
  const CustomCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SizedBox(
      width: widthHeightMiniCardPurple,
      height: widthHeightMiniCardPurple,
      child: Card(
        elevation: 0,
        color: color.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.6),
        ),
        clipBehavior: Clip.hardEdge,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
