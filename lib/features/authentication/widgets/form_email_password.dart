import 'package:flutter/material.dart';
import 'package:guardowl/features/authentication/widgets/text_field_custom.dart';

class FormEmailPassword extends StatelessWidget {
  const FormEmailPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        TextFieldCustom(labelTextField: 'Email'),
        SizedBox(height: 21),
        TextFieldCustom(labelTextField: 'Password'),
      ],
    );
  }
}
