import 'package:flutter/material.dart';
import 'package:guardowl/config/config.dart';
import 'package:guardowl/constants/enviroments_search_view.dart';
import 'package:guardowl/features/home/widgets/search_widgets.dart';
import 'package:guardowl/features/share/share.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, sizeHeightAppBar),
        child: MyAppBar(),
      ),
      body: ListView(
        // alignment: Alignment.center,
        children: const [
          MyBackground(
            child: RecentSearch(),
          ),
          MostVisitedCenters(),
          LocationMarkerData(),
        ],
      ),
    );
  }
}
