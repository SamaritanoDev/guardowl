import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/authentication/blocs/authentication/authentication_cubit.dart';
import 'package:guardowl/features/authentication/ui/widgets/text_field_custom.dart';

class FormEmailPassword extends StatelessWidget {
  const FormEmailPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = context.watch<AuthenticationCubit>();
    final email = authenticationCubit.state.email;
    final password = authenticationCubit.state.password;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        TextFieldCustom(
          labelTextField: 'Email',
          onChanged: authenticationCubit.emailChanged,
          errorMessage: email.errorMessage,
          obscureText: false,
        ),
        const SizedBox(height: 21),
        TextFieldCustom(
          labelTextField: 'Password',
          onChanged: authenticationCubit.passwordChanged,
          errorMessage: password.errorMessage,
          obscureText: true,
        ),
      ],
    );
  }
}
