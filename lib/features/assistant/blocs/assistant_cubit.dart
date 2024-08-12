import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_globals.dart';
import 'package:guardowl/constants/instructions.dart';
import 'package:guardowl/features/assistant/models/activity_model.dart';
import 'package:guardowl/features/assistant/models/chat_message.dart';
import 'package:guardowl/services/gemini_api_service.dart';

part 'assistant_state.dart';

class AssistantCubit extends Cubit<AssistantState> {
  AssistantCubit() : super(const AssistantInitial([]));

  final _geminiApiService = GeminiApiService(apiKey: valueApiKeyGemini);

  Future<void> sendInitialMessageEmptyDestination(ScrollController controller) async {
    try {
      const initialMessage = getInitialQuestionNoDestinationChat;
      emit(const AssistantLoading());

      final aiMessage = await _sendMessage(message: initialMessage);
      if (aiMessage != null) {
        emit(AssistantMessageLoaded([aiMessage]));
      }

      controller.jumpTo(controller.position.maxScrollExtent);
    } catch (e) {
      emit(AssistantError(e.toString()));
    }
  }

  Future<void> sendMessageWithDestination(
      {required String destination, List<ActivityModel>? activities, required ScrollController controller}) async {
    try {
      emit(const AssistantLoading());
      // Convertir la lista de actividades a una cadena que incluya todos los datos
      if (activities != null) {
        final activitiesString = activities
            .map((activity) =>
                'Name: ${activity.nameActivity}, Description: ${activity.nameDestination}, Location: ${activity.season}, Hours: ${activity.schedule}, Address: ${activity.address},')
            .join('; ');

        final instructionInitial =
            '$getInitialQuestionDestinationChat for $destination according to these activities: $activitiesString And ends with the question: If you need anything else you can ask me.';

        final aiMessage = await _sendMessage(message: instructionInitial, destination: destination);
        if (aiMessage != null) {
          emit(AssistantMessageLoaded([aiMessage]));
        }
      } else {
        final prompt =
            '$getInitialQuestionNoDestinationChatSecond for $destination And ends with the question: If you need anything else you can ask me.';

        final aiMessage = await _sendMessage(message: prompt, destination: destination);
        if (aiMessage != null) {
          emit(AssistantMessageLoaded([aiMessage]));
        }
      }

      controller.jumpTo(controller.position.maxScrollExtent);
    } catch (e) {
      emit(AssistantError(e.toString()));
    }
  }

  Future<ChatMessage?> _sendMessage({required String message, String? destination}) async {
    try {
      final aiResponse = await _geminiApiService.getResponse(message);

      final aiMessage = ChatMessage(
        userId: 'gemini_ai',
        message: aiResponse,
        createdAt: DateTime.now(),
        destination: destination ?? '',
      );
      return aiMessage;
    } catch (e) {
      emit(AssistantError(e.toString()));
      return null;
    }
  }

  void handleNewMessage(ChatMessage message) {
    final newMessages = [message, ..._getMessage()];
    emit(AssistantMessageLoaded(newMessages));
  }

  List<ChatMessage> _getMessage() {
    final currentState = state;

    if (currentState is AssistantMessageLoaded) {
      return currentState.messages;
    } else {
      return [];
    }
  }
}
