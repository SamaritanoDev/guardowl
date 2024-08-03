import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/authentication/blocs/sign_in/sign_in_cubit.dart';
import 'package:guardowl/features/authentication/blocs/valid_form/valid_form_register_cubit.dart';
import 'package:guardowl/features/authentication/ui/widgets/text_field_custom.dart';

class FormEmailPassword extends StatelessWidget {
  final Function(String) onChangedEmail;
  final Function(String) onChangedPassword;

  const FormEmailPassword({
    super.key,
    required this.onChangedEmail,
    required this.onChangedPassword,
  });

  @override
  Widget build(BuildContext context) {
    final validFormRegisterCubit = context.watch<ValidFormRegisterCubit>();
    final email = validFormRegisterCubit.state.email;
    final password = validFormRegisterCubit.state.password;

    final authenticationCubit = context.read<SignInCubit>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        TextFieldCustom(
          labelTextField: 'Email',
          onChanged: onChangedEmail,
          errorMessage: email.errorMessage,
          obscureText: false,
        ),
        const SizedBox(height: 21),
        BlocBuilder<SignInCubit, SignInState>(
          builder: (context, state) {
            return TextFieldCustom(
              labelTextField: 'Password',
              onChanged: onChangedPassword,
              errorMessage: password.errorMessage,
              obscureText: !state.passwordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  state.passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: authenticationCubit.togglePasswordVisibility,
              ),
            );
          },
        ),
      ],
    );
  }
}
