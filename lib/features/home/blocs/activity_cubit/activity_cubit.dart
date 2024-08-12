import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardowl/constants/enviroments_globals.dart';
import 'package:guardowl/constants/instructions.dart';
import 'package:guardowl/features/assistant/models/activity_model.dart';
import 'package:guardowl/services/gemini_api_service.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityInitial());

  Future<void> handleSearch(String destination) async {
    final geminiApiService = GeminiApiService(apiKey: valueApiKeyGemini);
    if (destination.isNotEmpty) {
      try {
        final instruction = '$getJsonCard for the destination $destination';

        emit(const ActivityLoading());

        final response = await geminiApiService.getResponse(instruction);

        final cleanedResponse = _cleanResponse(response);

        if (cleanedResponse.isEmpty) {
          emit(const ActivityError('Response is empty'));
        }

        final jsonResponse = jsonDecode(cleanedResponse) as Map<String, dynamic>;

        final activities =
            (jsonResponse["activities"] as List<dynamic>).map((item) => ActivityModel.fromJson(item)).toList();

        emit(ActivityLoaded(activities));
      } catch (e, st) {
        print('Error fetching response from Gemini: $e\n st:\n $st');
        emit(ActivityError(e.toString()));
      }
    }
  }

  static String _cleanResponse(String response) {
    final firstCorchete = response.indexOf('[');
    final lastCorchete = response.lastIndexOf(']');
    String recortado = response.substring(firstCorchete, lastCorchete + 1);

    // Agregar las llaves al inicio y al final
    return '{"activities":${recortado.trim()}}';
  }
}
