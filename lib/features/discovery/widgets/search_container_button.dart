import 'package:flutter/material.dart';
import 'package:guardowl/features/discovery/navigation_search_view.dart';

class SearchContainerButton extends StatelessWidget {
  const SearchContainerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => const NavigationSearchView(),
        ));
      },
      style: OutlinedButton.styleFrom(
        overlayColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: Colors.black,
        elevation: 4,
        side: BorderSide.none,
        padding: const EdgeInsets.all(12),
        alignment: Alignment.centerLeft,
        backgroundColor: Colors.white,
      ),
      child: Icon(
        Icons.search,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
