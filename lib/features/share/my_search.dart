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

  late GeminiApiService _geminiApiService;

  @override
  void initState() {
    super.initState();
    _geminiApiService = GeminiApiService(apiKey: valueApiKeyGemini);
  }

  Future<void> _handleSearch(String query) async {
    if (query.isNotEmpty) {
      try {
        final instruction = '$getJsonCard para el destino $query';

        final response = await _geminiApiService.getResponse(instruction);

        final cleanedResponse = _cleanResponse(response);

        if (cleanedResponse.isEmpty) {
          throw const FormatException('Response is empty');
        }

        final jsonResponse = jsonDecode(cleanedResponse) as Map<String, dynamic>;

        final activities =
            (jsonResponse["activities"] as List<dynamic>).map((item) => ActivityModel.fromJson(item)).toList();
        context.read<ActivityCubit>().setActivities(activities);
      } catch (e, st) {
        print('Error fetching response from Gemini: $e\n st:\n $st');
        context.read<ActivityCubit>().setError(e.toString());
      }
    }
  }

  String _cleanResponse(String response) {
    final firstCorchete = response.indexOf('[');
    final lastCorchete = response.lastIndexOf(']');
    String recortado = response.substring(firstCorchete, lastCorchete + 1);

    // Agregar las llaves al inicio y al final
    return '{"activities":${recortado.trim()}}';
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
