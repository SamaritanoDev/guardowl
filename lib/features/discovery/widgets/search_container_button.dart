import 'package:flutter/material.dart';
import 'package:guardowl/features/discovery/navigation_search/navigation_search_view.dart';

class SearchContainerButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SearchContainerButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return OutlinedButton(
      onPressed: () {
        onPressed();
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

class SearchSelectingCard extends StatelessWidget {
  const SearchSelectingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          '👇🏻 Seleccione un sitio',
          style: TextStyle(
            color: color.onPrimary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
