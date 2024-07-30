import 'package:flutter/material.dart';
import 'package:guardowl/config/config.dart';
import 'package:guardowl/constants/enviroments_my_theme.dart';

class MySearch extends StatefulWidget {
  const MySearch({super.key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  final TextEditingController _serachController = TextEditingController();
  TextStyle hintTextstyle = TextStyle(
    color: colorScheme.surfaceDim,
  );
  TextStyle inputTextstyle = TextStyle(
    color: colorScheme.scrim,
    fontSize: 14,
  );

  RoundedRectangleBorder boderRaiudSearch = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6),
  );

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Find my next destination...',
      controller: _serachController,
      shape: WidgetStateProperty.all(boderRaiudSearch),
      backgroundColor: WidgetStatePropertyAll(colorScheme.onPrimary),
      elevation: const WidgetStatePropertyAll(0.0),
      hintStyle: WidgetStatePropertyAll(hintTextstyle),
      textStyle: WidgetStatePropertyAll(inputTextstyle),
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.search,
          color: colorScheme.primary,
        ),
      ),
    );
  }
}
