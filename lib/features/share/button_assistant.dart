import 'package:flutter/material.dart';
import '../../constants/enviroments_assets.dart';

class ButtonAssistant extends StatelessWidget {
  const ButtonAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CircleAvatar(
      backgroundColor: colorScheme.primary,
      maxRadius: 45,
      child: CircleAvatar(
        backgroundColor: colorScheme.primaryContainer,
        maxRadius: 40,
        child: Image.asset(
          logoOwlPng,
          width: 46,
          height: 49.69,
        ),
      ),
    );
  }
}
