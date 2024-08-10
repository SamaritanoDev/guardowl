import 'package:flutter/material.dart';

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
