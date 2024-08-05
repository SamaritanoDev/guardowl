import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/authentication/blocs/login/login_cubit.dart';
import 'package:guardowl/features/authentication/ui/widgets/text_field_custom.dart';

class FormEmailPassword extends StatelessWidget {
  final Function(String) onChangedEmail;
  final Function(String) onChangedPassword;
  final String? errorMessageEmail;
  final String? errorMessagePassword;

  const FormEmailPassword({
    super.key,
    required this.onChangedEmail,
    required this.onChangedPassword,
    this.errorMessageEmail,
    this.errorMessagePassword,
  });

  @override
  Widget build(BuildContext context) {
    final logIncubit = context.read<LogInCubit>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        TextFieldCustom(
          labelTextField: 'Email',
          onChanged: onChangedEmail,
          errorMessage: errorMessageEmail,
          obscureText: false,
        ),
        const SizedBox(height: 21),
        BlocBuilder<LogInCubit, LogInState>(
          builder: (context, state) {
            
            return TextFieldCustom(
              labelTextField: 'Password',
              onChanged: onChangedPassword,
              errorMessage: errorMessagePassword,
              obscureText: !state.passwordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  state.passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: logIncubit.togglePasswordVisibility,
              ),
            );
          },
        ),
      ],
    );
  }
}
