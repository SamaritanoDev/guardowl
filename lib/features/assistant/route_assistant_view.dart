import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/constants/enviroments_globals.dart';

import 'package:guardowl/features/assistant/blocs/assistant_cubit.dart';

import 'package:guardowl/features/assistant/widgets/assistant_profile_headder.dart';
import 'package:guardowl/features/assistant/widgets/chat_box_input.dart';
import 'package:guardowl/features/assistant/widgets/chat_messages_list.dart';
import 'package:guardowl/features/assistant/widgets/options_list.dart';
import 'package:guardowl/features/home/blocs/activity_cubit/activity_cubit.dart';
import 'package:guardowl/features/home/blocs/search/search_cubit.dart';
import 'package:guardowl/features/share/my_app_bar_arrow.dart';

class RouteAssistantScreen extends StatefulWidget {
  const RouteAssistantScreen({super.key, this.destination});
  final String? destination;

  @override
  State<RouteAssistantScreen> createState() => _RouteAssistantScreenState();
}

class _RouteAssistantScreenState extends State<RouteAssistantScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _handleInitialMessage();
  }

  Future<void> _handleInitialMessage() async {
    final argumentDestination = widget.destination;
    if (argumentDestination.isValid) {
      context
          .read<AssistantCubit>()
          .sendMessageWithDestination(destination: argumentDestination!, controller: _controller);
    } else {
      final searchBarDestination = context.read<SearchCubit>().state.destination;
      final activityState = context.read<ActivityCubit>().state;
      if (activityState is ActivityLoaded) {
        final activities = activityState.activities;

        if (searchBarDestination.isValid && activities.isNotEmpty) {
          context.read<AssistantCubit>().sendMessageWithDestination(
                destination: searchBarDestination!,
                activities: activities,
                controller: _controller,
              );
        }
      } else {
        context.read<AssistantCubit>().sendInitialMessageEmptyDestination(_controller);
      }
    }
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
                ),
                Divider(color: color.primary),
                OptionsList(),
                const SizedBox(height: 16),
                const AssistantProfileHeader(),
              ],
            ),
          ),
          ChatBoxInput(
            apiKey: valueApiKeyGemini,
            scrollController: _controller,
            onNewMessage: context.read<AssistantCubit>().handleNewMessage,
          ),
        ],
      ),
    );
  }
}

extension _Valid on String? {
  bool get isValid => this != null && this!.isNotEmpty;
}
