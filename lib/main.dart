import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/config/config.dart';
import 'package:guardowl/features/authentication/blocs/authentication/authentication_valid_form_cubit.dart';
import 'package:guardowl/features/authentication/ui/authentication_view.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: const MainApp(),
    ),
  );
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
      home: const AuthenticationView(),
    );
  }
}
