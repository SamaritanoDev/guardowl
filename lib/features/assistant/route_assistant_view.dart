import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/constants/enviroments_globals.dart';
import 'package:guardowl/constants/instructions.dart';
import 'package:guardowl/features/assistant/models/activity_model.dart';
import 'package:guardowl/features/assistant/models/chat_message.dart';
import 'package:guardowl/features/assistant/widgets/assistant_profile_headder.dart';
import 'package:guardowl/features/assistant/widgets/chat_box_input.dart';
import 'package:guardowl/features/assistant/widgets/chat_messages_list.dart';
import 'package:guardowl/features/assistant/widgets/options_list.dart';
import 'package:guardowl/features/home/blocs/activity_cubit/activity_cubit.dart';
import 'package:guardowl/features/home/blocs/search/search_cubit.dart';
import 'package:guardowl/features/share/my_app_bar_arrow.dart';
import 'package:guardowl/services/gemini_api_service.dart';

class RouteAssistantScreen extends StatefulWidget {
  const RouteAssistantScreen({super.key});

  @override
  State<RouteAssistantScreen> createState() => _RouteAssistantScreenState();
}

class _RouteAssistantScreenState extends State<RouteAssistantScreen> {
  final ScrollController _controller = ScrollController();
  final List<ChatMessage> _messages = [];
  late GeminiApiService _geminiApiService;

  @override
  void initState() {
    super.initState();
    _geminiApiService = GeminiApiService(apiKey: valueApiKeyGemini);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _handleInitialMessage();
  }

  Future<void> _handleInitialMessage() async {
    final destination = context.read<SearchCubit>().state.destination;

    // Agregar un retraso pequeño para esperar que las actividades se carguen
    await Future.delayed(const Duration(milliseconds: 500));

    final activityState = context.read<ActivityCubit>().state;

    if (activityState is ActivityLoaded) {
      final activities = activityState.activities;
      if (destination != null && destination.isNotEmpty) {
        if (activities.isNotEmpty) {
          _sendMessageNoEmptyDestination(destination, activities);
        }
      }
    } else {
      // Si no se ha cargado el estado de actividades, aún puedes enviar el mensaje inicial vacío
      _sendInitialMessageEmptyDestination();
      print("ActivityCubit no ha cargado las actividades");
    }
  }

  Future<void> _sendInitialMessageEmptyDestination() async {
    try {
      const initialMessage = getInitialQuestionNoDestinationChat;
      final aiResponse = await _geminiApiService.getResponse(initialMessage);

      final aiMessage = ChatMessage(
        userId: 'gemini_ai',
        message: aiResponse,
        createdAt: DateTime.now(),
        destination: '',
      );

      setState(() {
        _messages.insert(0, aiMessage);
      });

      _controller.jumpTo(_controller.position.maxScrollExtent);
    } catch (e, st) {
      print('Error: $e , ST: $st');
    }
  }

  Future<void> _sendMessageNoEmptyDestination(
      String destination, List<ActivityModel> activities) async {
    try {
      print("destino $destination");

      // Convertir la lista de actividades a una cadena que incluya todos los datos
      final activitiesString = activities
          .map((activity) =>
              'Name: ${activity.nameActivity}, Description: ${activity.nameDestination}, Location: ${activity.season}, Hours: ${activity.schedule}, Address: ${activity.address},')
          .join('; ');

      final instructionInitial =
          '$getInitialQuestionDestinationChat for $destination according to these activities: $activitiesString And ends with the question: If you need anything else you can ask me.';

      final aiResponse =
          await _geminiApiService.getResponse(instructionInitial);

      final aiMessage = ChatMessage(
        userId: 'gemini_ai',
        message: aiResponse,
        createdAt: DateTime.now(),
        destination: destination,
      );

      setState(() {
        _messages.insert(0, aiMessage);
      });

      _controller.jumpTo(_controller.position.maxScrollExtent);
    } catch (e, st) {
      print('Error: $e , ST: $st');
    }
  }

  void _handleNewMessage(ChatMessage message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.onPrimary,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: MyAppBarArrow(title: 'Route Assistant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
              reverse: true,
              controller: _controller,
              children: [
                ChatMessagesList(
                  controller: _controller,
                  messages: _messages,
                ),
                Divider(color: color.primary),
                OptionsList(),
                const SizedBox(height: 16),
                const AssistantProfileHeader(),
              ],
            ),
          ),
          ChatBoxInput(
            apiKey: valueApiKeyGemini,
            scrollController: _controller,
            onNewMessage: _handleNewMessage,
          ),
        ],
      ),
    );
  }
}
