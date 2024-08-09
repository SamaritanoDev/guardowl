import 'package:flutter/material.dart';
import 'package:guardowl/features/discovery/widgets/continue_navigation_button.dart';
import 'package:guardowl/features/discovery/widgets/from_to_inputs.dart';
import 'package:guardowl/features/discovery/widgets/routing_icons.dart';
import 'package:guardowl/features/share/my_app_bar_arrow.dart';

class NavigationSearchView extends StatefulWidget {
  const NavigationSearchView({
    super.key,
  });

  @override
  State<NavigationSearchView> createState() => _NavigationSearchViewState();
}

class _NavigationSearchViewState extends State<NavigationSearchView> {
  final _formKey = GlobalKey<FormState>();
  String fronAddress = '';
  String toAddress = '';
  bool isLoading = false;

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
                    Expanded(
                      child: FromToInputs(
                        isLoading: isLoading,
                        onChangedTo: (value) => setState(
                          () => toAddress = value,
                        ),
                        onChangedFrom: (value) => setState(
                          () => fronAddress = value,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Expanded(child: SizedBox()),
                ContinueNavigationButton(
                  fromAddress: fronAddress,
                  toAddress: toAddress,
                ),
                const SizedBox(height: 30),
              ],
            ),
          )),
    );
  }
}
