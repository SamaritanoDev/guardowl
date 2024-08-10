import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_globals.dart';

class MySearch extends StatefulWidget {
  const MySearch({super.key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  final TextEditingController _destinationSerachController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    TextStyle hintTextstyle = TextStyle(
      color: color.surfaceTint,
    );
    TextStyle inputTextstyle = TextStyle(
      color: color.scrim,
      fontSize: 14,
    );

    RoundedRectangleBorder boderRaiudSearch = RoundedRectangleBorder(
      borderRadius: borderRadiusCircularInput,
    );

    return SearchBar(
      onSubmitted: (value) {
        Navigator.pushNamed(context, '/route-assistant');
      },
      hintText: 'Find my next destination...',
      controller: _destinationSerachController,
      shape: WidgetStateProperty.all(boderRaiudSearch),
      backgroundColor: WidgetStatePropertyAll(color.onPrimary),
      elevation: const WidgetStatePropertyAll(0.0),
      hintStyle: WidgetStatePropertyAll(hintTextstyle),
      textStyle: WidgetStatePropertyAll(inputTextstyle),
      leading: Icon(
        Icons.search,
        color: color.primary,
      ),
    );
  }
}
