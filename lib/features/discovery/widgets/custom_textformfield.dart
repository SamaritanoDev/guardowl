import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.action,
    required this.isLoading,
    required this.onChanged,
  });

  final String label;
  final bool isLoading;
  final TextInputAction action;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      textInputAction: action,
      keyboardAppearance: Brightness.light,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        labelText: label,
        enabled: !isLoading,
        enabledBorder: InputBorder.none,
        fillColor: const Color(0xffF0F0F0),
      ),
    );
  }
}
