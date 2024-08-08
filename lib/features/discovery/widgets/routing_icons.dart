import 'package:flutter/material.dart';

class RoutingIcons extends StatelessWidget {
  const RoutingIcons({
    super.key,
    required this.primaryColor,
  });

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.radio_button_checked,
          color: color.primary,
        ),
        const SizedBox(height: 8),
        ...List.generate(
          3,
          (_) => Container(
            height: 4.5,
            width: 2,
            color: color.onSurfaceVariant,
            margin: const EdgeInsets.only(bottom: 8),
          ),
        ),
        Icon(
          Icons.my_location_sharp,
          color: color.primary,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
