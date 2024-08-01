import 'package:flutter/material.dart';

class MyCardImage extends StatelessWidget {
  final String urlImage;
  final String titleCategory;
  final String countVisit;
  const MyCardImage({
    super.key,
    required this.urlImage,
    required this.titleCategory,
    required this.countVisit,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              urlImage,
              width: 173.34,
              height: 177.0,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.4),
              colorBlendMode: BlendMode.darken,
            ),
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_outline_outlined,
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
                      Text(
                        titleCategory,
                        style: textTheme.titleLarge?.copyWith(
                          fontSize: 18,
                          color: color.inversePrimary,
                        ),
                      ),
                      Text(
                        countVisit,
                        style: textTheme.bodySmall?.copyWith(
                          color: color.inversePrimary,
                        ),
                      ),
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
