import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.action,
    required this.isLoading,
    required this.initialValue,
    required this.onTap,
  });

  final String label;
  final bool isLoading;
  final String? initialValue;
  final TextInputAction action;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      //  enabled: !isLoading,
      initialValue: initialValue,
      readOnly: true,
      textInputAction: action,
      keyboardAppearance: Brightness.light,
      onTap: onTap,
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
