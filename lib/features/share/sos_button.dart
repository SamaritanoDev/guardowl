import 'package:flutter/material.dart';

class SosButton extends StatelessWidget {
  const SosButton({super.key});

  @override
  Widget build(BuildContext context) {
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
        overlayColor: Colors.white,
        elevation: 7,
        shadowColor: Colors.black,
        padding: const EdgeInsets.all(12),
        backgroundColor: const Color.fromARGB(255, 255, 103, 121),
      ),
      child: const Text(
        'SOS',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
