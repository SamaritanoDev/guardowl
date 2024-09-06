import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/config/config.dart';
import 'package:guardowl/features/assistant/blocs/assistant_cubit.dart';
import 'package:guardowl/features/authentication/blocs/auth/auth_cubit.dart';
import 'package:guardowl/features/authentication/blocs/login/login_cubit.dart';
import 'package:guardowl/features/authentication/blocs/sign_up/sign_up_cubit.dart';
import 'package:guardowl/features/authentication/ui/authentication_view.dart';
import 'package:guardowl/features/destinations/cubit/destinations_cubit.dart';
import 'package:guardowl/features/home/blocs/activity_cubit/activity_cubit.dart';
import 'package:guardowl/features/home/blocs/search/search_cubit.dart';
import 'package:guardowl/features/home/views/favourites_view.dart';
import 'package:guardowl/features/discovery/navigation_search/bloc/navigation_search_bloc.dart';
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
        BlocProvider(create: (context) => ActivityCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => AssistantCubit()),
      ],
      child: MaterialApp(
        initialRoute: '/home',
        debugShowCheckedModeBanner: false,
        title: 'GuardOwl',
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        onGenerateRoute: (settings) {
          _Page page;

          switch (settings.name) {
            case '/login':
              page = _Page(pageWidget: const AuthenticationView());
              break;
            case '/home':
              page = _Page(pageWidget: const CustomNavigationBar());
              break;
            case '/favourites':
              page = _Page(pageWidget: const FavouritesView());
              break;
            case '/route-assistant':
              page = _Page(
                  pageWidget: RouteAssistantScreen(
                    destination: settings.arguments as String?,
                  ),
                  isLikeDialog: true);
              break;
            default:
              page = _Page(pageWidget: const SizedBox()); // error page
          }

          return MaterialPageRoute(
            builder: (context) => page.pageWidget,
            fullscreenDialog: page.isLikeDialog,
          );
        },
      ),
    );
  }
}

class _Page {
  _Page({
    required this.pageWidget,
    this.isLikeDialog = false,
  });

  final Widget pageWidget;
  final bool isLikeDialog;
}
