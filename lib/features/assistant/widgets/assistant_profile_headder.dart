import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/authentication/blocs/auth/auth_cubit.dart';
import 'package:guardowl/features/share/button_assistant.dart';

class AssistantProfileHeader extends StatelessWidget {
  const AssistantProfileHeader({super.key});

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
            const Hero(
              tag: '/assistant-button',
              child: ButtonAssistant(),
            ),
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
                      child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) => state.currentUser,
                          builder: (context, state) {
                            return Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                color: color.primaryContainer,
                              ),
                              child: Text(
                                '@${state.fullName}',
                                style: TextStyle(
                                  color: color.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }),
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
                    'My name is GuardOwl. I am designed to guide you through your journey. You can ask me about these topics:',
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
