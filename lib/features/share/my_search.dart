import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_globals.dart';
import 'package:guardowl/services/gemini_api_service.dart';

class MySearch extends StatefulWidget {
  const MySearch({super.key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  final TextEditingController _destinationSerachController =
      TextEditingController();

  late GeminiApiService _geminiApiService;

  @override
  void initState() {
    super.initState();
    _geminiApiService = GeminiApiService(apiKey: valueApiKeyGemini);
  }

  Future<void> _handleSearch(String query) async {
    if (query.isNotEmpty) {
      try {
        // Enviar el prompt a Gemini y recibir la respuesta
        final prompt = 'Find destinations related to: $query';
        final response = await _geminiApiService.getResponse(prompt);
        print('Gemini response: $response');

        // Navegar a RouteAssistantScreen con el prompt (opcional)
        // Navigator.pushNamed(
        //   context,
        //   '/route-assistant',
        //   arguments: {'prompt': response},
        // );
      } catch (e) {
        print('Error fetching response from Gemini: $e');
      }
    }
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
      // onSubmitted: (value) {
      //   Navigator.pushNamed(context, '/route-assistant');
      // },
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
