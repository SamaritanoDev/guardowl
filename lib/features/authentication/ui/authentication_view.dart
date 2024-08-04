import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/constants/constants.dart';
import 'package:guardowl/features/authentication/blocs/auth/auth_cubit.dart';
import 'package:guardowl/features/authentication/blocs/login/login_cubit.dart';
import 'package:guardowl/features/authentication/blocs/sign_up/sign_up_cubit.dart';
import 'package:guardowl/features/authentication/ui/register_view.dart';
import 'package:guardowl/features/authentication/ui/widgets/widgets_auhtentication.dart';
import 'package:guardowl/features/share/share.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  bool isRegisterMode = true;

  void toggleAuthMode() {
    setState(() {
      isRegisterMode = !isRegisterMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Building AuthenticationView with isRegisterMode: $isRegisterMode");

    const singInStyleButton =
        ButtonStyle(minimumSize: WidgetStatePropertyAll(Size(300, 50)));
    final color = Theme.of(context).colorScheme;
    final logInCubit = context.read<LogInCubit>();
    final signUpCubit = context.read<SignUpCubit>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.isSignedIn) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/home');
          });
          return CircularProgressIndicator(color: color.primary);
        } else {
          return Scaffold(
            body: ListView(
              children: [
                MyBackground(
                  height: 1.4,
                  child: Center(
                    child: HeaderAuthentication(
                        titleAuthentication:
                            isRegisterMode ? 'Sing In' : 'Sign Up',
                        subTitleAuthentication: isRegisterMode
                            ? 'Hi! Welcome back, you have been missed'
                            : 'Create your new account'),
                  ),
                ),
                isRegisterMode ? const SingInView() : const RegisterView(),
                const SizedBox(height: 20),
                //button home
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: paddingAppBar),
                  child: FilledButton(
                    style: singInStyleButton,
                    onPressed: () {
                      if (isRegisterMode) {
                        print(
                            "Button pressed, isRegisterMode: $isRegisterMode");
                        logInCubit.validtatingInputsLogIn();
                        logInCubit.logInWithCredentials();
                      } else {
                        signUpCubit.validtatingInputsSignUp();
                        signUpCubit.signUpWithCredentials();
                      }
                    },
                    child: const Text('Continue'),
                  ),
                ),
                const SizedBox(height: 30),
                const _LineOtherSocial(),
                const SizedBox(height: 35),
                //butons of social
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ButtonSocialNetwork(iconGoogle),
                    SizedBox(width: 30),
                    _ButtonSocialNetwork(iconApple),
                  ],
                ),
                const SizedBox(height: 35),
                LinkAccount(
                  routeName: isRegisterMode ? 'up' : 'in',
                  questionText: isRegisterMode
                      ? 'Don’t have an account?'
                      : 'If you have an account?',
                  onpressed: toggleAuthMode,
                ),
                const SizedBox(height: 35),
              ],
            ),
          );
        }
      },
    );
  }
}

class _ButtonSocialNetwork extends StatelessWidget {
  final String iconPath;
  const _ButtonSocialNetwork(this.iconPath);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return IconButton.filled(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(50, 50)),
        side: WidgetStatePropertyAll(
          BorderSide(width: 2, color: color.primary),
        ),
        backgroundColor: WidgetStatePropertyAll(
          color.primaryContainer,
        ),
      ),
      onPressed: () {},
      icon: Image.asset(
        iconPath,
        width: 27,
        height: 27,
      ),
    );
  }
}

class _LineOtherSocial extends StatelessWidget {
  const _LineOtherSocial();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final subtitleSocialStyle = textTheme.bodyMedium?.copyWith(
      color: color.primary,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 20.0),
        const _LineCustom(),
        Text('Other social networks', style: subtitleSocialStyle),
        const _LineCustom(),
        const SizedBox(width: 20.0),
      ],
    );
  }
}

class _LineCustom extends StatelessWidget {
  const _LineCustom();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;

    return Container(
      padding: EdgeInsets.all(paddingBorder),
      color: const Color(0xffc1c1c1),
      width: width * 0.25,
      height: 1,
    );
  }
}
