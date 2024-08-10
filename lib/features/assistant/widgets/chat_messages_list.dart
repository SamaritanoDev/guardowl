import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/assistant/models/chat_message.dart';
import 'package:guardowl/features/authentication/blocs/auth/auth_cubit.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key, required this.controller});

  final ScrollController controller;

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

    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) => state.currentUser,
        builder: (context, state) {
          return StreamBuilder<List<ChatMessage>>(
            stream: fetchMessages(),
            builder: (ctx, AsyncSnapshot<List<ChatMessage>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              final messages = snapshot.data!;

              return ListView.builder(
                shrinkWrap: true,
                controller: controller,
                itemCount: messages.length,
                itemBuilder: (ctx, index) {
                  final message = messages[index];

                  final isUserMessage =
                      message.userId == state.currentUser?.uid;
                  final (left, right) =
                      (isUserMessage ? 25.0 : 0.0, isUserMessage ? 0.0 : 25.0);
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 7, bottom: 7, left: left, right: right),
                    child: ListTile(
                      title: Text(message.message),
                      subtitle: isUserMessage
                          ? Text('You', style: textStyleYou)
                          : Text('Guardowl AI', style: textStyleAssistant),
                      tileColor: isUserMessage
                          ? color.secondary
                          : color.primaryContainer,
                    ),
                  );
                },
              );
            },
          );
        });
  }
}

Stream<List<ChatMessage>> fetchMessages() {
  final firestore = FirebaseFirestore.instance;
  try {
    final messages = firestore
        .collection('messages')
        .orderBy('createdAt')
        // .where(
        //   'destination',
        //   isEqualTo: 'Lima',
        // )
        .withConverter<ChatMessage>(
          fromFirestore: (snapshot, _) => ChatMessage.fromFirebaseUser(
            snapshot.data()!,
          ),
          toFirestore: (value, _) => value.toMapFirestore(),
        )
        .snapshots()
        .map((snapshot) => snapshot.docs)
        .map((docs) => docs.map((doc) => doc.data()))
        .map((messages) => messages.toList());

    return messages;
  } catch (e) {
    return throw Exception('Failed to load data');
  }
}
