import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guardowl/features/assistant/models/chat_message.dart';
import 'package:guardowl/services/gemini_api_service.dart';

class ChatBoxInput extends StatefulWidget {
  final String apiKey;
  final ScrollController scrollController;
  const ChatBoxInput({
    super.key,
    required this.apiKey,
    required this.scrollController,
  });

  @override
  State<ChatBoxInput> createState() => _ChatBoxInputState();
}

class _ChatBoxInputState extends State<ChatBoxInput> {
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

      // Add user message to Firestore
      await _firestore.collection('messages').add(UserMessage(
            userId: _auth.currentUser!.uid,
            createdAt: Timestamp.now().toDate(), // check this.
            message: userMessage,
            destination: 'Lima', // get this from searchfield
          ).toMapFirestore());

      // Get response from Gemini AI
      try {
        final aiResponse = await _geminiApiService.getResponse(userMessage);

        // Add AI response to Firestore
        await _firestore.collection('messages').add(GuardOwlMessage(
              userId: 'gemini_ai',
              createdAt: Timestamp.now().toDate(),
              message: aiResponse,
              destination: 'Lima',
            ).toMapFirestore());

        // Scroll to bottom after adding new messages
        widget.scrollController
            .jumpTo(widget.scrollController.position.maxScrollExtent);
      } catch (e, st) {
        print('Error: $e , ST: $st');
      }
    }
  }
}
