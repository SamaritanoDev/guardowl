import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_search_view.dart';
import 'package:guardowl/features/share/my_search.dart';

class HeaderSearch extends StatelessWidget {
  const HeaderSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(
        left: paddingAppBar,
        right: paddingAppBar,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "Travel with confidence, your safety is our priority",
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color.onPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Travel smarter with Guardowl.",
            style: textTheme.bodyMedium?.copyWith(
              color: color.onPrimary,
            ),
          ),
          const SizedBox(height: 18),
          const MySearch(),
        ],
      ),
    );
  }
}
