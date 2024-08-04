import 'package:flutter/material.dart';
import 'package:guardowl/constants/constants.dart';

class CustomButtonIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  const CustomButtonIcon({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        icon,
        size: sizeIconsAppBar,
        color: color.onPrimary,
      ),
    );
  }
}
