import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/discovery/navigation_search/bloc/navigation_search_bloc.dart';
import 'package:guardowl/features/discovery/navigation_search/widgets/continue_navigation_button.dart';
import 'package:guardowl/features/discovery/navigation_search/widgets/from_to_inputs.dart';
import 'package:guardowl/features/discovery/widgets/routing_icons.dart';
import 'package:guardowl/features/share/my_app_bar_arrow.dart';

class NavigationSearchView extends StatefulWidget {
  const NavigationSearchView({super.key});

  @override
  State<NavigationSearchView> createState() => _NavigationSearchViewState();
}

class _NavigationSearchViewState extends State<NavigationSearchView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.onPrimary,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: MyAppBarArrow(),
      ),
      body: Container(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoutingIcons(primaryColor: primaryColor),
                    const SizedBox(width: 15),
                    const Expanded(child: FromToInputs()),
                  ],
                ),
                const SizedBox(height: 30),
                const Expanded(child: SizedBox()),
                BlocSelector<NavigationSearchBloc, NavigationSearchState, bool>(
                  selector: (state) => state.isEnablingNavigation,
                  builder: (context, isEnablingNavigation) {
                    return ContinueNavigationButton(
                        onPressed: isEnablingNavigation
                            ? () {
                                context
                                    .read<NavigationSearchBloc>()
                                    .add(const ChangeShowRoute(true));
                                Navigator.of(context).pop();
                              }
                            : null);
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          )),
    );
  }
}
