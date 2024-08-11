import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessagesList extends StatelessWidget {
  final ScrollController controller;

  const ChatMessagesList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textStyleYou = textTheme.labelSmall?.copyWith(
      color: color.shadow,
    );

    final textStyleAssistant = textTheme.labelSmall?.copyWith(
      color: color.primary,
      fontWeight: FontWeight.bold,
    );

    final textBodyYou = textTheme.bodyMedium?.copyWith(
      color: color.shadow,
    );

    final textBodyAssistant = textTheme.bodySmall?.copyWith(
      color: color.primary,
      fontWeight: FontWeight.bold,
    );

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No messages yet.'));
        }

        final messages = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          controller: controller,
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isUserMessage = message['userId'] != 'gemini_ai';

            return ListTile(
              title: Align(
                alignment: isUserMessage
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: isUserMessage
                    ? Text('You', style: textStyleYou)
                    : Text('Guardowl AI', style: textStyleAssistant),
              ),
              subtitle: Align(
                alignment: isUserMessage
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: isUserMessage
                        ? color.secondary
                        : color.primaryContainer,
                  ),
                  child: Text(
                    message['message'],
                    style: isUserMessage ? textBodyYou : textBodyAssistant,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
