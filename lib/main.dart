import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guardowl/config/config.dart';
import 'package:guardowl/features/assistant/route_assistant_view.dart';
import 'package:guardowl/features/share/custom_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: '/',
      routes: {
        '/': (_) => const CustomNavigationBar(),
        '/route-assistant': (_) => const RouteAssistantScreen(),
      },
    );
  }
}
