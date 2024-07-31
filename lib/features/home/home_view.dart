import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_search_view.dart';
import 'package:guardowl/features/home/widgets/search_widgets.dart';
import 'package:guardowl/features/share/share.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, sizeHeightAppBar),
        child: MyAppBar(),
      ),
      body: ListView(
        children: const [
          MyBackground(
            child: HeaderSearch(),
          ),
          MostVisitedCenters(),
          LocationMarkerData(),
        ],
      ),
    );
  }
}
