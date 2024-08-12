import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/constants/constants.dart';
import 'package:guardowl/features/assistant/widgets/loading_widget.dart';
import 'package:guardowl/features/home/blocs/activity_cubit/activity_cubit.dart';
import 'package:guardowl/features/home/widgets/activiy_list.dart';
import 'package:guardowl/features/home/widgets/destinations_list.dart';
import 'package:guardowl/features/home/widgets/my_drawer.dart';
import 'package:guardowl/features/home/widgets/search_widgets.dart';
import 'package:guardowl/features/share/share.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final textTitleLargePrimary = textTheme.titleLarge?.copyWith(
      color: color.primary,
      fontWeight: FontWeight.bold,
    );

    final textError = textTheme.bodyLarge?.copyWith(
      color: color.error,
      fontWeight: FontWeight.bold,
    );

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 270,
              child: MyBackground(
                height: heightMyBackgroung,
                child: const HeaderSearch(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: paddingAppBar),
              child: Text(
                "Destinations you must visit",
                style: textTitleLargePrimary,
              ),
            ),
            const SizedBox(height: 30),
            BlocBuilder<ActivityCubit, ActivityState>(
              builder: (context, state) {
                if (state is ActivityLoaded) {
                  return SizedBox(
                    height: 400,
                    child: ActivitiesList(activities: state.activities),
                  );
                } else if (state is ActivityError) {
                  return Center(
                    child: Text('Error: ${state.error}', style: textError),
                  );
                } else if (state is ActivityLoading) {
                  return const LoadingAssistant();
                } else {
                  return const Center(
                    child: DestinationsList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
