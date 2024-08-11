import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guardowl/features/assistant/widgets/bubble.message.dart';

class ChatMessagesList extends StatelessWidget {
  final ScrollController controller;

  const ChatMessagesList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('messages').orderBy('createdAt', descending: true).snapshots(),
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

            return BubbleMessage(
              isUserMessage: isUserMessage,
              message: message['message'],
            );
          },
        );
      },
    );
  }
}
