import 'package:flutter/material.dart';

class MyCardImage extends StatelessWidget {
  final String urlImage;
  final String titleDestination;
  final String location;
  final String place;
  final VoidCallback onPressed;
  const MyCardImage({
    super.key,
    required this.urlImage,
    required this.titleDestination,
    required this.location,
    required this.place, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      color: color.onPrimary,
      child: Stack(
        children: [
          Image.network(
            urlImage,
            width: double.infinity,
            height: 400,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.4),
            colorBlendMode: BlendMode.darken,
          ),
          Positioned(
            right: 5,
            top: 5,
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.favorite_outline_outlined,
                  color: color.tertiary, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
