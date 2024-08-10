import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/constants/enviroments_search_view.dart';
import 'package:guardowl/features/destinations/cubit/destinations_cubit.dart';
import 'package:guardowl/features/share/my_app_bar_arrow.dart';
import 'package:guardowl/features/share/photo_item_list.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textTitleLargePrimary = textTheme.titleLarge?.copyWith(
      color: color.primary,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    final favorites = context.watch<DestinationCubit>().state.favorites;

    return Scaffold(
      backgroundColor: color.onPrimary,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: MyAppBarArrow(title: 'My wish list'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 33),
            child: Text(
              "Destinations I want to visit:",
              style: textTitleLargePrimary,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingAppBar),
              child: favorites.isEmpty
                  ? const _MessageIsEmptyFavorites()
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: favorites.length,
                        itemBuilder: (BuildContext context, int index) {
                          final destination = favorites[index];
                          return PhotoListItem(destination: destination);
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageIsEmptyFavorites extends StatelessWidget {
  const _MessageIsEmptyFavorites();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textMessage = textTheme.bodyLarge?.copyWith(
      color: color.primary,
    );
    const singInStyleButton =
        ButtonStyle(minimumSize: WidgetStatePropertyAll(Size(300, 50)));

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: Text(
              "You have not added any destination to visit, add one from the beginning.",
              style: textMessage,
            ),
          ),
          const SizedBox(height: 100),
          FilledButton(
            style: singInStyleButton,
            onPressed: () => Navigator.pushNamed(context, '/home'),
            child: const Text('There I go...'),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
