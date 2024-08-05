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
    final media = MediaQuery.of(context);
    final width = media.size.width / 2.5;
    final validFormSignUpCubit = context.watch<SignUpCubit>();
    final firstName = validFormSignUpCubit.state.firstName;
    final lastName = validFormSignUpCubit.state.lastName;
    final email = validFormSignUpCubit.state.email;
    final password = validFormSignUpCubit.state.password;

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
                  onChanged: validFormSignUpCubit.firstNameChanged,
                  errorMessage: firstName.errorMessage,
                  obscureText: false,
                  width: width,
                ),
                const Spacer(),
                TextFieldCustom(
                  labelTextField: 'Last name',
                  onChanged: validFormSignUpCubit.lastNameChanged,
                  errorMessage: lastName.errorMessage,
                  obscureText: false,
                  width: width,
                )
              ],
            ),
            const SizedBox(height: 15),
            FormEmailPassword(
              onChangedEmail: readSignUpCubit.emailChanged,
              onChangedPassword: readSignUpCubit.passwordChanged,
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
