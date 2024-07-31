import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_globals.dart';

class TextFieldCustom extends StatelessWidget {
  final String labelTextField;
  final double? width;
  const TextFieldCustom({
    super.key,
    required this.labelTextField,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final labelStyle = textTheme.titleMedium?.copyWith(
      color: color.primary,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelTextField, style: labelStyle),
        const SizedBox(height: 5),
        SizedBox(
          width: width,
          height: 50,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: borderRadiusCircularInput,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
