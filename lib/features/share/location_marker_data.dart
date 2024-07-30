import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_my_theme.dart';
import 'package:guardowl/constants/enviroments_search_view.dart';

class LocationMarkerData extends StatelessWidget {
  const LocationMarkerData({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);
    final width = media.size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 15.13),
        Padding(
          padding: const EdgeInsets.only(right: paddingAppBar),
          child: Text(
            "See All",
            style: textTheme.bodyMedium,
          ),
        ),
        Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: paddingAppBar),
          child: const Column(
            children: [
              _ListTileLocationMarker(
                namePlace: "Mall of Indonesia",
                nameLocation: "Kelapa Gading, Jakarta Utara",
                distanceToLocation: "1.2 km",
              ),
              _ListTileLocationMarker(
                namePlace: "Mall of Indonesia",
                nameLocation: "Kelapa Gading, Jakarta Utara",
                distanceToLocation: "1.2 km",
              ),
              _ListTileLocationMarker(
                namePlace: "Mall of Indonesia",
                nameLocation: "Kelapa Gading, Jakarta Utara",
                distanceToLocation: "1.2 km",
              ),
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
    final textTheme = Theme.of(context).textTheme;
    final textBodySmallGray =
        textTheme.bodySmall?.copyWith(color: colorScheme.outline);

    return ListTile(
      leading: const CustomCard(
        child: Icon(
          Icons.location_on,
        ),
      ),
      iconColor: colorScheme.primary,
      title: Text(namePlace, style: textTheme.titleMedium),
      subtitle: Text(nameLocation, style: textBodySmallGray),
      trailing: Text(distanceToLocation, style: textBodySmallGray),
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
    //Color colorPurpleOpacity = const Color.fromARGB(20, 85, 96, 210);
    Color colorPurpleOpacity = const Color(0xffebecfa);
    return SizedBox(
      width: widthHeightMiniCardPurple,
      height: widthHeightMiniCardPurple,
      child: Card(
        elevation: 0,
        color: colorPurpleOpacity,
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
