import 'package:flutter/material.dart';

class OptionsList extends StatelessWidget {
  final List<String> options = [
    'Plan Activities',
    'Recommendations',
  ];

  OptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final lableStyle = textTheme.labelLarge?.copyWith(
      color: color.onPrimary,
    );

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options
          .map(
            (option) => ActionChip(
              color: WidgetStatePropertyAll(color.primary),
              label: Text(option, style: lableStyle),
              onPressed: () {
                // Handle option selection
              },
            ),
          )
          .toList(),
    );
  }
}
