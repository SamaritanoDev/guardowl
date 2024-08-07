import 'package:flutter/material.dart';
import 'package:guardowl/constants/constants.dart';
import 'package:guardowl/features/home/widgets/my_drawer.dart';
import 'package:guardowl/features/home/widgets/search_widgets.dart';
import 'package:guardowl/features/share/share.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final media = MediaQuery.of(context);
    final width = media.size.width;

    return Scaffold(
      drawer: Drawer(
        width: width,
        shadowColor: color.secondary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: const MyDrawer(),
      ),
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
        ],
      ),
    );
  }
}
