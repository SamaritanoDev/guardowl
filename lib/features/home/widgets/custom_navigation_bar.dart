import 'package:flutter/material.dart';
import 'package:guardowl/features/discovery/discovery_view.dart';
import 'package:guardowl/features/home/home_view.dart';
import 'package:guardowl/features/share/share.dart';

enum _Pages { home, discovery }

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

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

    final NavigationBarThemeData navigationBarThemeData =
        NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.all(
          textTheme.labelSmall?.copyWith(color: color.primary)),
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.large(
        tooltip: ' I’m your route assistant',
        onPressed: () {},
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
          _Pages.discovery =>
            const DiscoveryView(key: PageStorageKey('DiscoveryView'))
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
