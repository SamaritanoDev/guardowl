import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guardowl/features/share/share.dart';
import 'package:guardowl/services/gemini_api_service.dart';

class RouteAssistantScreen extends StatefulWidget {
  const RouteAssistantScreen({super.key});

  @override
  State<RouteAssistantScreen> createState() => _RouteAssistantScreenState();
}

class _RouteAssistantScreenState extends State<RouteAssistantScreen> {
  final _messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final GeminiApiService _geminiApiService = GeminiApiService();

  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      final userMessage = _messageController.text;
      _messageController.clear();

      // Add user message to Firestore
      await _firestore.collection('messages').add({
        'text': userMessage,
        'createdAt': Timestamp.now(),
        'userId': _auth.currentUser!.uid,
      });

      // Get response from Gemini AI
      try {
        final aiResponse = await _geminiApiService.getResponse(userMessage);

        // Add AI response to Firestore
        await _firestore.collection('messages').add({
          'text': aiResponse,
          'createdAt': Timestamp.now(),
          'userId': 'gemini_ai', // Use a different ID for AI responses
        });
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Assistant'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            const SizedBox(height: 16),
            OptionsList(),
            // const Spacer(),
            Expanded(
              child: StreamBuilder(
                stream: _firestore
                    .collection('messages')
                    .orderBy('createdAt')
                    .snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final messages = snapshot.data!.docs;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (ctx, index) {
                      final message = messages[index];
                      final isUserMessage =
                          message['userId'] == _auth.currentUser!.uid;
                      return ListTile(
                        title: Text(message['text']),
                        subtitle: isUserMessage
                            ? const Text('You')
                            : const Text('Guardowl AI'),
                        tileColor:
                            isUserMessage ? Colors.blue[100] : Colors.grey[200],
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
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
                    color: color.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 50.0,
                  height: 44.0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_upward, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final textTitleLargeAlert = textTheme.titleLarge?.copyWith(
      color: color.primary,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    return Column(
      children: [
        Row(
          children: [
            const ButtonAssistant(),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "GuardOwl",
                  style: textTitleLargeAlert,
                ),
                Text(
                  "Your assitant",
                  style: textTheme.bodyMedium?.copyWith(
                    color: color.outlineVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Hi',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          color: color.primaryContainer,
                        ),
                        child: Text(
                          '@Name',
                          style: TextStyle(
                            color: color.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Welcome! 🎉',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text(
                    'My name is Jacob. I’m 🤖 designed to guide you during your trip. I will show you the safety places:',
                    style: TextStyle(fontSize: 14),
                    softWrap: true,
                    overflow: TextOverflow.clip,
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}

class OptionsList extends StatelessWidget {
  final List<String> options = [
    'Create routes',
    'Explore destinations',
    'Plan Activities',
    'Gastronomy',
    'Events',
    'Accommodation',
  ];

  OptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options
          .map(
            (option) => ActionChip(
              label: Text(option),
              onPressed: () {
                // Handle option selection
              },
            ),
          )
          .toList(),
    );
  }
}
