import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/assistant/blocs/assistant_cubit.dart';
import 'package:guardowl/features/assistant/widgets/bubble.message.dart';
import 'package:guardowl/features/assistant/widgets/loading_widget.dart';

class ChatMessagesList extends StatelessWidget {
  final ScrollController controller;

  const ChatMessagesList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssistantCubit, AssistantState>(
        listener: (context, state) => state,
        builder: (context, state) {
          if (state is AssistantInitial) {
            return _StateWidget(
              child: Text('initial: ${state.messages}'),
            );
          } else if (state is AssistantLoading) {
            return const _StateWidget(
              child: LoadingAssistant(),
            );
          } else if (state is AssistantError) {
            return _StateWidget(
              child: Text('Error: ${state.error}'),
            );
          } else if (state is AssistantMessageLoaded) {
            return ListView.builder(
              shrinkWrap: true,
              controller: controller,
              reverse: true,
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final message = state.messages[index];
                final isUserMessage = message.userId != 'gemini_ai';

                return BubbleMessage(
                  isUserMessage: isUserMessage,
                  message: message.message,
                );
              },
            );
          } else {
            return const Center(child: Text("Unknown State"));
          }
        });
  }
}

class _StateWidget extends StatelessWidget {
  const _StateWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 50),
          child,
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
