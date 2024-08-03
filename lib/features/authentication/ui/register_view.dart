import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/constants/constants.dart';
import 'package:guardowl/features/authentication/blocs/sign_in/sign_in_cubit.dart';
import 'package:guardowl/features/authentication/ui/widgets/form_email_password.dart';
import 'package:guardowl/features/authentication/ui/widgets/text_field_custom.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = 160.00;

    final authenticationCubit = context.watch<SignInCubit>();
    final firstName = authenticationCubit.state.firstName;
    final lastName = authenticationCubit.state.lastName;

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
                  onChanged: authenticationCubit.onFirstNameChanged,
                  errorMessage: firstName.errorMessage,
                  obscureText: false,
                  width: width,
                ),
                const Spacer(),
                TextFieldCustom(
                  labelTextField: 'Last name',
                  onChanged: authenticationCubit.onLastNameChanged,
                  errorMessage: lastName.errorMessage,
                  obscureText: false,
                  width: width,
                )
              ],
            ),
            const SizedBox(height: 15),
            const FormEmailPassword(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
