import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/discovery/discovery_bloc_page.dart';
import 'package:guardowl/features/home/home_view.dart';
import 'package:guardowl/features/discovery/bloc/location_bloc.dart';
import 'package:guardowl/features/share/share.dart';

enum _Pages { home, discovery }

extension _PagesExtension on _Pages {
  ({IconData icon, IconData selectedIcon, String label}) get resources =>
      switch (this) {
        _Pages.home => (
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
            label: 'Search',
          ),
        _Pages.discovery => (
            icon: Icons.map_outlined,
            selectedIcon: Icons.map_sharp,
            label: 'Discover',
          ),
      };
}

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final PageStorageBucket bucket = PageStorageBucket();

  _Pages currentPage = _Pages.home;

  static const _destinationViews = [
    _Pages.home,
    _Pages.discovery,
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    final navigationBarThemeData = NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.all(
          textTheme.labelSmall?.copyWith(color: color.primary)),
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.large(
        heroTag: '/assistant-button',
        tooltip: ' I’m your route assistant',
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/route-assistant',
          );
        },
        shape: const CircleBorder(),
        elevation: 3,
        splashColor: color.primaryContainer,
        child: const ButtonAssistant(),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: navigationBarThemeData,
        child: NavigationBar(
            height: 74,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            indicatorColor: Colors.transparent,
            elevation: 2,
            backgroundColor: color.primaryContainer,
            onDestinationSelected: (int index) {
              setState(() {
                currentPage = _destinationViews[index];
              });
            },
            selectedIndex: currentPage.index,
            destinations: _destinationViews
                .map(_NavigationDestinationCustom.new)
                .toList()),
      ),
      body: PageStorage(
        bucket: bucket,
        child: switch (currentPage) {
          _Pages.home => const HomeView(key: PageStorageKey('HomeView')),
          _Pages.discovery => DiscoveryView(
              key: const PageStorageKey('DiscoveryView'),
              onInit: () => context
                  .read<LocationBloc>()
                  .add(const LocationStreamRequestedOpen()),
              onDispose: () => context
                  .read<LocationBloc>()
                  .add(const LocationStreamRequestedClose()),
            )
        },
      ),
    );
  }
}

class _NavigationDestinationCustom extends StatelessWidget {
  final _Pages page;

  const _NavigationDestinationCustom(this.page);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    final resources = page.resources;
    return NavigationDestination(
      selectedIcon: Icon(resources.selectedIcon, color: color.primary),
      icon: Icon(resources.icon, color: color.surfaceTint),
      label: resources.label,
    );
  }
}
