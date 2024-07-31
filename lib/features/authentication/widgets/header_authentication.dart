import 'package:flutter/material.dart';
import 'package:guardowl/constants/constants.dart';

class HeaderAuthentication extends StatelessWidget {
  final String titleAuthentication;
  final String subTitleAuthentication;
  const HeaderAuthentication({
    super.key,
    required this.titleAuthentication,
    required this.subTitleAuthentication,
  });

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
        Text(titleAuthentication, style: titleSingInStyle),
        const SizedBox(height: 10),
        Text(subTitleAuthentication, style: subtitleSingInStyle),
        const SizedBox(height: 5),
        Image.asset(logoOwlPng, width: 60, height: 75),
      ],
    );
  }
}
