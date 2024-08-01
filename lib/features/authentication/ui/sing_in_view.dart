import 'package:flutter/material.dart';
import 'package:guardowl/constants/constants.dart';
import 'package:guardowl/features/authentication/ui/widgets/form_email_password.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingBorder),
      child: const Column(
        children: [
          FormEmailPassword(),
          _RecoverPassword(),
        ],
      ),
    );
  }
}

class _RecoverPassword extends StatelessWidget {
  const _RecoverPassword();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final linkStyle = textTheme.titleSmall?.copyWith(
      decoration: TextDecoration.underline,
      decorationColor: color.primary,
      color: color.primary,
    );
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        style: const ButtonStyle(
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
        ),
        child: Padding(
          padding: EdgeInsets.only(right: paddingBorder),
          child: Text("Forgot Password?", style: linkStyle),
        ),
      ),
    );
  }
}
