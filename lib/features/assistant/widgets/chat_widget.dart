import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guardowl/features/assistant/widgets/assistant_profile_headder.dart';
import 'package:guardowl/features/assistant/widgets/options_list.dart';
import 'package:guardowl/services/gemini_api_service.dart';

class ChatWidget3 extends StatelessWidget {
  final String apiKey;

  const ChatWidget3({super.key, required this.apiKey});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Column(
      children: [
        const AssistantProfileHeader(),
        OptionsList(),
        const Divider(),
        Expanded(
          child: ChatMessagesList3(controller: scrollController),
        ),
        ChatBoxInput3(apiKey: apiKey, scrollController: scrollController),
      ],
    );
  }
}

class ChatMessagesList3 extends StatelessWidget {
  final ScrollController controller;

  const ChatMessagesList3({super.key, required this.controller});

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

class ChatBoxInput3 extends StatefulWidget {
  final String apiKey;
  final ScrollController scrollController;

  const ChatBoxInput3(
      {super.key, required this.apiKey, required this.scrollController});

  @override
  State<ChatBoxInput3> createState() => _ChatBoxInput3State();
}

class _ChatBoxInput3State extends State<ChatBoxInput3> {
  final _messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late GeminiApiService _geminiApiService;

  @override
  void initState() {
    super.initState();
    _geminiApiService = GeminiApiService(apiKey: widget.apiKey);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      color: color.primary,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: color.onPrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 44.0,
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: color.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            width: 50.0,
            height: 44.0,
            child: IconButton(
              icon: Icon(Icons.arrow_upward, color: color.shadow),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      final userMessage = _messageController.text;
      _messageController.clear();

      final userId = _auth.currentUser!.uid;

      // Add user message to Firestore
      await _firestore.collection('messages').add({
        'userId': userId,
        'createdAt': Timestamp.now(),
        'message': userMessage,
        'destination': 'Lima', // get this from searchfield or another source
      });

      // Get response from Gemini AI
      try {
        final aiResponse = await _geminiApiService.getResponse(userMessage);

        // Add AI response to Firestore
        await _firestore.collection('messages').add({
          'userId': 'gemini_ai',
          'createdAt': Timestamp.now(),
          'message': aiResponse,
          'destination': 'Lima',
        });

        // Scroll to bottom after adding new messages
        widget.scrollController
            .jumpTo(widget.scrollController.position.maxScrollExtent);
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}
