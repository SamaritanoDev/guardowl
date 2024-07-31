import 'package:flutter/material.dart';
import 'package:guardowl/constants/constants.dart';
import 'package:guardowl/constants/enviroments_globals.dart';
import 'package:guardowl/features/authentication/widgets/text_field_custom.dart';
import 'package:guardowl/features/home/widgets/search_widgets.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    const singInStyleButton = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(300, 50)),
    );

    return Scaffold(
      body: Column(
        children: [
          MyBackground(
            height: heightMyBackgroung,
            child: const Center(
              child: _HeaderSingIn(),
            ),
          ),
          //Form
          const _FormEmailPassword(),
          const _RecoverPassword(),
          const SizedBox(height: 20),
          FilledButton(
            style: singInStyleButton,
            onPressed: () {},
            child: const Text('Continue'),
          ),
          const SizedBox(height: 40),
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
        ],
      ),
    );
  }
}

class _FormEmailPassword extends StatelessWidget {
  const _FormEmailPassword();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingBorder),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          TextFieldCustom(labelTextField: 'Email'),
          SizedBox(height: 21),
          TextFieldCustom(labelTextField: 'Password'),
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

class _HeaderSingIn extends StatelessWidget {
  const _HeaderSingIn();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final titleSingInStyle = textTheme.headlineLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: color.onPrimary,
    );
    final subtitleSingInStyle = textTheme.bodyMedium?.copyWith(
      color: color.onPrimary,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sing In', style: titleSingInStyle),
        const SizedBox(height: 10),
        Text('Hi! Welcome back, you have been missed.',
            style: subtitleSingInStyle),
        const SizedBox(height: 5),
        Image.asset(logoOwlPng, width: 60, height: 75),
      ],
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
