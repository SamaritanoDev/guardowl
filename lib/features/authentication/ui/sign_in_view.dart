import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/constants/constants.dart';
import 'package:guardowl/features/authentication/blocs/login/login_cubit.dart';
import 'package:guardowl/features/authentication/ui/widgets/form_email_password.dart';

class SingInView extends StatelessWidget {
  const SingInView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final readLogInCubit = context.read<LogInCubit>();
    final validFormRegisterCubit = context.watch<LogInCubit>();
    final email = validFormRegisterCubit.state.email;
    final password = validFormRegisterCubit.state.password;

    return Padding(
      padding: EdgeInsets.all(paddingBorder),
      child: Column(
        children: [
          FormEmailPassword(
            // onChangedEmail: logInCubit.emailChanged,
            // onChangedPassword: logInCubit.passwordChanged,
            onChangedEmail: (email) => readLogInCubit.emailChanged(email),
            onChangedPassword: (password) =>
                readLogInCubit.passwordChanged(password),
                errorMessageEmail: email.errorMessage,
                errorMessagePassword: password.errorMessage,
          ),
          const _RecoverPassword(),
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
