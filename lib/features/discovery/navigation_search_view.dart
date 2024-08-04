import 'package:flutter/material.dart';
import 'package:guardowl/features/discovery/widgets/continue_navigation_button.dart';
import 'package:guardowl/features/discovery/widgets/from_to_inputs.dart';
import 'package:guardowl/features/discovery/widgets/routing_icons.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 80,
        leading: Center(
            child: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_outlined,
            size: 30,
          ),
        )),
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
