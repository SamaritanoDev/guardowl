import 'package:flutter/material.dart';
import 'package:guardowl/features/assistant/widgets/assistant_profile_headder.dart';
import 'package:guardowl/features/assistant/widgets/chat_box_input.dart';
import 'package:guardowl/features/assistant/widgets/chat_messages_list.dart';
import 'package:guardowl/features/assistant/widgets/options_list.dart';
import 'package:guardowl/features/share/my_app_bar_arrow.dart';

class RouteAssistantScreen extends StatelessWidget {
  RouteAssistantScreen({super.key});

  final ScrollController _controller = ScrollController();

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
              ChatMessagesList(controller: _controller),
              const Divider(),
              OptionsList(),
              const SizedBox(height: 16),
              const AssistantProfileHeader(),
            ],
          )),
          const ChatBoxInput(),
        ],
      ),
    );
  }
}
