import 'package:flutter/material.dart';
import 'package:guardowl/features/discovery/navigation_search_view.dart';

class SearchContainerButton extends StatelessWidget {
  const SearchContainerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => const NavigationSearchView(),
        ));
      },
      style: OutlinedButton.styleFrom(
        overlayColor: color.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: color.shadow,
        elevation: 4,
        side: BorderSide.none,
        padding: const EdgeInsets.all(12),
        alignment: Alignment.centerLeft,
        backgroundColor: color.onPrimary,
      ),
      child: Icon(
        Icons.search,
        color: color.primary,
      ),
    );
  }
}
