import 'package:flutter/material.dart';
import 'package:guardowl/features/assistant/models/chat_message.dart';
import 'package:guardowl/features/assistant/widgets/bubble.message.dart';

class ChatMessagesList extends StatelessWidget {
  final ScrollController controller;
  final List<ChatMessage> messages;

  const ChatMessagesList({
    super.key,
    required this.controller,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const Center(
          child: Column(
        children: [
          SizedBox(height: 200),
          CircularProgressIndicator(),
          SizedBox(height: 200),
        ],
      ));
    }

    return ListView.builder(
      shrinkWrap: true,
      controller: controller,
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isUserMessage = message.userId != 'gemini_ai';

        return BubbleMessage(
          isUserMessage: isUserMessage,
          message: message.message,
        );
      },
    );
  }
}
