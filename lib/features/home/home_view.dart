import 'package:flutter/material.dart';
import 'package:guardowl/constants/constants.dart';
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
        children: [
          SizedBox(
            height: 270,
            child: MyBackground(
              height: heightMyBackgroung,
              child: const HeaderSearch(),
            ),
          ),
          const MostVisitedCenters(),
          const LocationMarkerData(),
        ],
      ),
    );
  }
}
