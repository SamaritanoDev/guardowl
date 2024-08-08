import 'package:flutter/material.dart';

class SosButton extends StatelessWidget {
  const SosButton({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    
    return OutlinedButton(
      onPressed: () {
        // TODO: add global onPressed method
        // or add onPressed callback as argument
        //to reuse with differents methods
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide.none,
        shape: const CircleBorder(),
        // change the splash color when tap this button.
        overlayColor: color.onPrimary,
        elevation: 7,
        shadowColor: color.shadow,
        padding: const EdgeInsets.all(12),
        backgroundColor: color.tertiary,
      ),
      child: Text(
        'SOS',
        style: TextStyle(
          color: color.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
