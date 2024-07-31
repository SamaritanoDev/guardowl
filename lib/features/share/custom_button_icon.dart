import 'package:flutter/material.dart';
import 'package:guardowl/constants/constants.dart';

class CustomButtonIcon extends StatelessWidget {
  final IconData icon;
  const CustomButtonIcon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {},
      child: Icon(
        icon,
        size: sizeIconsAppBar,
        color: color.onPrimary,
      ),
    );
  }
}
