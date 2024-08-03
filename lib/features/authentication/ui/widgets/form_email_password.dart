import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/authentication/blocs/sign_in/sign_in_cubit.dart';
import 'package:guardowl/features/authentication/ui/widgets/text_field_custom.dart';

class FormEmailPassword extends StatelessWidget {
  const FormEmailPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = context.read<SignInCubit>();
    final email = authenticationCubit.state.email;
    final password = authenticationCubit.state.password;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        TextFieldCustom(
          labelTextField: 'Email',
          onChanged: authenticationCubit.onChangeEmail,
          errorMessage: email.errorMessage,
          obscureText: false,
        ),
        const SizedBox(height: 21),
        BlocBuilder<SignInCubit, SignInState>(
          builder: (context, state) {
            return TextFieldCustom(
              labelTextField: 'Password',
              onChanged: authenticationCubit.onChangePassword,
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
