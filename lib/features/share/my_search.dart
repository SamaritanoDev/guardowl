import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_globals.dart';
import 'package:guardowl/constants/instructions.dart';
import 'package:guardowl/features/assistant/models/activity_model.dart';
import 'package:guardowl/features/home/blocs/activity_cubit/activity_cubit.dart';
import 'package:guardowl/services/gemini_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySearch extends StatefulWidget {
  const MySearch({super.key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  final TextEditingController _destinationSerachController = TextEditingController();

  Future<void> _handleSearch(String query) async {
    context.read<ActivityCubit>().handleSearch(query);
  }

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
      // onTap: () => testJsonDecoding(),
      onSubmitted: (value) {
        _handleSearch(value);
      },
      hintText: 'Where in Peru are you going?',
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
