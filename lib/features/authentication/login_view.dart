import 'package:flutter/material.dart';
import 'package:guardowl/constants/constants.dart';
import 'package:guardowl/features/authentication/widgets/text_field_custom.dart';
import 'package:guardowl/features/home/widgets/search_widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    const singInStyleButton = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(300, 50)),
    );

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      body: Column(
        children: [
          const MyBackground(
            child: Center(
              child: _HeaderSingIn(),
            ),
          ),
          //Form
          const _FormEmailPassword(),
          const _RecoverPassword(),
          const SizedBox(height: 30),
          FilledButton(
            style: singInStyleButton,
            onPressed: () {},
            child: const Text('Continue'),
          ),
          const SizedBox(height: 50),
          const _LineOtherSocial(),
          const SizedBox(height: 35),
          //butons of social
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ButtonSocialNetwork(MdiIcons.google),
              const SizedBox(width: 30),
              _ButtonSocialNetwork(MdiIcons.apple),
            ],
          )
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
    final textTheme = Theme.of(context).textTheme;
    final linkStyle = textTheme.titleSmall?.copyWith(
      decoration: TextDecoration.underline,
      decorationColor: colorScheme.primary,
      color: colorScheme.primary,
    );
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        onHover: (value) => linkStyle,
        style: const ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.transparent)),
        child: Padding(
          padding: EdgeInsets.only(right: paddingBorder),
          child: Text("Forgot Password?", style: linkStyle),
        ),
      ),
    );
  }
}

class _ButtonSocialNetwork extends StatelessWidget {
  final IconData icon;
  const _ButtonSocialNetwork(this.icon);

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(50, 50)),
        side: WidgetStatePropertyAll(
          BorderSide(width: 2, color: colorScheme.primary),
        ),
        backgroundColor: WidgetStatePropertyAll(
          colorScheme.secondary,
        ),
      ),
      onPressed: () {},
      icon: Icon(icon, color: colorScheme.primary),
    );
  }
}

class _HeaderSingIn extends StatelessWidget {
  const _HeaderSingIn();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleSingInStyle = textTheme.headlineLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: colorScheme.onPrimary,
    );
    final subtitleSingInStyle = textTheme.bodyMedium?.copyWith(
      color: colorScheme.onPrimary,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sing In', style: titleSingInStyle),
        const SizedBox(height: 10),
        Text('Hi ! Welcome back, you have been missed.',
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
    final textTheme = Theme.of(context).textTheme;
    final subtitleSocialStyle = textTheme.bodyMedium?.copyWith(
      color: colorScheme.primary,
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
