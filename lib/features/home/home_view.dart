import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/constants/constants.dart';
import 'package:guardowl/features/assistant/widgets/loading_widget.dart';
import 'package:guardowl/features/destinations/cubit/destinations_cubit.dart';
import 'package:guardowl/features/home/blocs/activity_cubit/activity_cubit.dart';
import 'package:guardowl/features/home/widgets/activiy_list.dart';
import 'package:guardowl/features/home/widgets/destinations_list.dart';
import 'package:guardowl/features/home/widgets/my_drawer.dart';
import 'package:guardowl/features/home/widgets/search_widgets.dart';
import 'package:guardowl/features/home/widgets/wraper_scroll.dart';
import 'package:guardowl/features/share/share.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<DestinationCubit>().loadMoreDestinations();
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.5);
  }

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
        body: BlocBuilder<ActivityCubit, ActivityState>(builder: (context, state) {
          return WrapperScroll(
            scrollController: scrollController,
            children: [
              SizedBox(
                height: 270,
                child: MyBackground(
                  height: heightMyBackgroung,
                  child: const HeaderSearch(),
                ),
              ).convertScrollWidget,
              Padding(
                padding: const EdgeInsets.only(left: paddingAppBar),
                child: Text(
                  "Destinations you must visit",
                  style: textTitleLargePrimary,
                ),
              ).convertScrollWidget,
              const SizedBox(height: 30).convertScrollWidget,
              get(state),
            ],
          );
        }));
  }

  ScrollWidget get(ActivityState state) {
    if (state is ActivityLoaded) {
      //   final textError = textTheme.bodyLarge?.copyWith(
      //   color: color.error,
      //   fontWeight: FontWeight.bold,
      // );

      return ActivitiesList(
        activities: state.activities,
      ).convertScrollWidget.scrollable;
    } else if (state is ActivityError) {
      return Center(
        child: Text(
          'Error: ${state.error}',
        ),
      ).convertScrollWidget;
    } else if (state is ActivityLoading) {
      return const LoadingAssistant().convertScrollWidget;
    } else {
      return const DestinationsList().convertScrollWidget.scrollable;
    }
  }
}
