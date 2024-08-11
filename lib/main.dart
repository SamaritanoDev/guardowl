import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/config/config.dart';
import 'package:guardowl/features/authentication/blocs/auth/auth_cubit.dart';
import 'package:guardowl/features/authentication/blocs/login/login_cubit.dart';
import 'package:guardowl/features/authentication/blocs/sign_up/sign_up_cubit.dart';
import 'package:guardowl/features/authentication/ui/authentication_view.dart';
import 'package:guardowl/features/destinations/cubit/destinations_cubit.dart';
import 'package:guardowl/features/discovery/navigation_search/bloc/navigation_search_bloc.dart';
import 'package:guardowl/features/favourites/favourites_view.dart';
import 'package:guardowl/features/home/widgets/custom_navigation_bar.dart';
import 'package:guardowl/features/discovery/bloc/location_bloc.dart';
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
        BlocProvider(
            create: (context) =>
                LocationBloc()..add(const LocationRequested())),
        BlocProvider(create: (context) => NavigationSearchBloc()),
      ],
      child: MaterialApp(
        initialRoute: '/login',
        debugShowCheckedModeBanner: false,
        title: 'GuardOwl',
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        onGenerateRoute: (settings) {
          final route = _Routes.values.firstWhere(
            (r) => r.name == settings.name,
            // Ruta no encontrada, podrían retornar una pantalla de error.
            orElse: () => _Routes.error,
          );

          return MaterialPageRoute(
            builder: (context) => route.page,
            fullscreenDialog: route.isLikeDialog,
          );
        },
      ),
    );
  }
}

enum _Routes { login, home, favourites, routeAssistant, error }

extension _RoutesInfo on _Routes {
  String get name => routeInfo.name;
  Widget get page => routeInfo.page;
  // modificar segun sea necesario
  bool get isLikeDialog => _Routes.routeAssistant == this;

  ({String name, Widget page}) get routeInfo => switch (this) {
        _Routes.login => (
            name: '/login',
            page: const AuthenticationView(),
          ),
        _Routes.home => (
            name: '/home',
            page: const CustomNavigationBar(),
          ),
        _Routes.favourites => (
            name: '/favourites',
            page: const FavouritesView(),
          ),
        _Routes.routeAssistant => (
            name: '/route-assistant',
            page: RouteAssistantScreen(),
          ),
        // build error page
        _Routes.error => (name: '/error-page', page: const SizedBox()),
      };
}
