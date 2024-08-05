import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_globals.dart';

class TextFieldCustom extends StatelessWidget {
  final String labelTextField;
  final double? width;
  final String? errorMessage;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  const TextFieldCustom({
    super.key,
    required this.labelTextField,
    this.width,
    this.errorMessage,
    required this.obscureText,
    this.onChanged,
    this.validator, this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final labelStyle = textTheme.titleMedium?.copyWith(
      color: color.primary,
    );
    final border = OutlineInputBorder(borderRadius: borderRadiusCircularInput);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelTextField, style: labelStyle),
        const SizedBox(height: 5),
        SizedBox(
          width: width,
          child: TextFormField(
            onChanged: onChanged,
            validator: validator,
            obscureText: obscureText,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              errorBorder:
                  border.copyWith(borderSide: BorderSide(color: color.error)),
              isDense: true,
              errorText: errorMessage,
              focusColor: color.primary,
              border: OutlineInputBorder(
                borderRadius: borderRadiusCircularInput,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
