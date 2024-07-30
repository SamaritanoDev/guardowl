import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_my_theme.dart';
import 'package:guardowl/constants/enviroments_search_view.dart';
import 'package:guardowl/features/home/widgets/my_card_image.dart';

class MostVisitedCenters extends StatelessWidget {
  const MostVisitedCenters({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: paddingAppBar),
          child: Text(
            "Most visited tourist centers",
            style: textTheme.titleLarge?.copyWith(
              fontSize: 18,
              color: colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: heightCardImage,
          width: width,
          child: ListView.builder(
            itemExtent: widthCardImage,
            padding: const EdgeInsets.symmetric(horizontal: paddingAppBar),
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return const MyCardImage(
                urlImage:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Machu_Picchu%2C_Peru_%282018%29.jpg/800px-Machu_Picchu%2C_Peru_%282018%29.jpg',
                titleCategory: 'Machu Pichu',
                countVisit: '720 person vist',
              );
            },
          ),
        ),
      ],
    );
  }
}
