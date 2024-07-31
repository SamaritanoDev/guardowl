import 'package:flutter/material.dart';
import 'package:guardowl/constants/constants.dart';
import 'package:guardowl/features/authentication/widgets/form_email_password.dart';
import 'package:guardowl/features/authentication/widgets/text_field_custom.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = 160.00;

    return Padding(
      padding: EdgeInsets.all(paddingBorder),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFieldCustom(
                labelTextField: 'First name',
                width: width,
              ),
              const Spacer(),
              TextFieldCustom(
                labelTextField: 'Last name',
                width: width,
              )
            ],
          ),
          const SizedBox(height: 20),
          const FormEmailPassword(),
          const SizedBox(height: 33),
        ],
      ),
    );
  }
}
