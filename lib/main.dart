import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/config/config.dart';
import 'package:guardowl/features/authentication/blocs/auth/auth_cubit.dart';
import 'package:guardowl/features/authentication/blocs/login/login_cubit.dart';
import 'package:guardowl/features/authentication/blocs/sign_up/sign_up_cubit.dart';
import 'package:guardowl/features/authentication/ui/authentication_view.dart';
import 'package:guardowl/features/destinations/cubit/destinations_cubit.dart';
import 'package:guardowl/features/favourites/favourites_view.dart';
import 'package:guardowl/features/home/widgets/custom_navigation_bar.dart';
import 'package:guardowl/features/assistant/route_assistant_view.dart';
import 'package:guardowl/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final textTheme = createTextTheme(context, "Poppins", "Poppins");
    final theme = MaterialTheme(textTheme);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => LogInCubit()),
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => DestinationCubit()),
      ],
      child: MaterialApp(
        initialRoute: '/login',
        debugShowCheckedModeBanner: false,
        title: 'GuardOwl',
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        routes: {
          '/login': (context) => const AuthenticationView(),
          '/home': (context) => const CustomNavigationBar(),
          '/favourites': (context) => const FavouritesView(),
          '/route-assistant': (_) => const RouteAssistantScreen(),
        },
      ),
    );
  }
}
