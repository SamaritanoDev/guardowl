import 'package:flutter/material.dart';

class ContinueNavigationButton extends StatelessWidget {
  const ContinueNavigationButton({
    super.key,
    required this.onPressed,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'Continuar',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
