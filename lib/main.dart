import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/config/config.dart';
import 'package:guardowl/features/authentication/blocs/sign_in/sign_in_cubit.dart';
import 'package:guardowl/features/authentication/ui/authentication_view.dart';
import 'package:guardowl/features/home/widgets/custom_navigation_bar.dart';
import 'package:guardowl/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  final isAuthenticated = user != null;

  runApp(MainApp(
    isAuthenticated: isAuthenticated,
  ));
}

class MainApp extends StatelessWidget {
  final bool isAuthenticated;
  const MainApp({
    super.key,
    required this.isAuthenticated,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final textTheme = createTextTheme(context, "Poppins", "Poppins");
    final theme = MaterialTheme(textTheme);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInCubit(
            isAuthenticated ? Authenticated() : NotAuthenticated(),
          ),
        ),
      ],
      child: MaterialApp(
        initialRoute: isAuthenticated ? '/home' : '/login',
        debugShowCheckedModeBanner: false,
        title: 'GuardOwl',
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        routes: {
          '/login': (context) => const AuthenticationView(),
          '/home': (context) => const CustomNavigationBar(),
        },
      ),
    );
  }
}
