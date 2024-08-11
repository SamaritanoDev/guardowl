import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_globals.dart';
import 'package:guardowl/features/assistant/models/chat_message.dart';
import 'package:guardowl/features/assistant/widgets/assistant_profile_headder.dart';
import 'package:guardowl/features/assistant/widgets/chat_box_input.dart';
import 'package:guardowl/features/assistant/widgets/chat_messages_list.dart';
import 'package:guardowl/features/assistant/widgets/options_list.dart';
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

    _sendInitialMessage();
  }

  Future<void> _sendInitialMessage() async {
    try {
      const initialMessage =
          'Ask the user which destination in Peru he or she wants to travel to or visit, in a natural tone';
      final aiResponse = await _geminiApiService.getResponse(initialMessage);

      print('Gemini Response: $aiResponse');

      final aiMessage = ChatMessage(
        userId: 'gemini_ai',
        message: aiResponse,
        createdAt: DateTime.now(),
        destination: 'Lima',
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
                const Divider(),
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
