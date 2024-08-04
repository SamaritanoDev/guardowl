import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/constants/constants.dart';
import 'package:guardowl/features/authentication/blocs/sign_up/sign_up_cubit.dart';
import 'package:guardowl/features/authentication/ui/widgets/form_email_password.dart';
import 'package:guardowl/features/authentication/ui/widgets/text_field_custom.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = 160.00;
    final signUpCubit = context.watch<SignUpCubit>();
    final firstName = signUpCubit.state.firstName;
    final lastName = signUpCubit.state.lastName;
    final email = signUpCubit.state.email;
    final password = signUpCubit.state.password;

    final readSignUpCubit = context.read<SignUpCubit>();
    return Form(
      child: Padding(
        padding: EdgeInsets.all(paddingBorder),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldCustom(
                  labelTextField: 'First name',
                  // onChanged: signUpCubit.firstNameChanged,
                  onChanged: (value) =>
                      context.read<SignUpCubit>().firstNameChanged(value),
                  errorMessage: firstName.errorMessage,
                  obscureText: false,
                  width: width,
                ),
                const Spacer(),
                TextFieldCustom(
                  labelTextField: 'Last name',
                  // onChanged: signUpCubit.lastNameChanged,
                  onChanged: (value) => readSignUpCubit.lastNameChanged(value),
                  errorMessage: lastName.errorMessage,
                  obscureText: false,
                  width: width,
                )
              ],
            ),
            const SizedBox(height: 15),
            FormEmailPassword(
              // onChangedEmail: readSignUpCubit.emailChanged,
              // onChangedPassword: readSignUpCubit.passwordChanged,
              onChangedEmail: (email) =>
                  context.read<SignUpCubit>().emailChanged(email),
              onChangedPassword: (password) =>
                  context.read<SignUpCubit>().passwordChanged(password),
              errorMessageEmail: email.errorMessage,
              errorMessagePassword: password.errorMessage,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
