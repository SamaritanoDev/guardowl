import 'package:flutter/material.dart';

class MyCardImage extends StatelessWidget {
  final String urlImage;
  final String titleDestination;
  final String location;
  final String place;
  const MyCardImage({
    super.key,
    required this.urlImage,
    required this.titleDestination,
    required this.location,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    final textTitleCard = textTheme.titleSmall?.copyWith(
      color: color.inversePrimary,
    );
    final textSubTitleCard =
        textTheme.bodySmall?.copyWith(color: color.secondary);

    const width = 173.34;

    return Card(
      clipBehavior: Clip.hardEdge,
      color: color.onPrimary,
      child: Stack(
        children: [
          Image.network(
            urlImage,
            width: double.infinity,
            height: 115,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.4),
            colorBlendMode: BlendMode.darken,
          ),
          Positioned(
            right: 5,
            top: 5,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_outline_outlined,
                  color: color.tertiary, size: 30),
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
                      width: width,
                      child: Text(
                        titleDestination,
                        style: textTitleCard,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: color.secondary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          location,
                          style: textSubTitleCard,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '- ',
                          style: textSubTitleCard,
                        ),
                        Text(
                          place,
                          style: textSubTitleCard,
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [

                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
