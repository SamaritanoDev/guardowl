import 'package:flutter/material.dart';
import 'package:guardowl/config/config.dart';
import 'package:guardowl/features/authentication/authentication_view.dart';
import 'package:guardowl/features/home/home_view.dart';
import 'package:guardowl/features/share/custom_navigation_bar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final textTheme = createTextTheme(context, "Poppins", "Poppins");
    final theme = MaterialTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GuardOwl',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const CustomNavigationBar(),
    );
  }
}
