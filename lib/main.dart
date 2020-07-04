import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/authentication/bloc/authentication_bloc.dart';
import 'package:my_social_app/common/observers/app_bloc_observer.dart';
import 'package:my_social_app/common/widgets/splash_screen.dart';
import 'package:my_social_app/home_screen.dart';
import 'package:my_social_app/user/data/repositories/user_repository.dart';

import 'home_screen.dart';
import 'login/screens/login_screen.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (context, state) {
            if (state is Uninitialized) {
              return SplashScreen();
            } else if (state is Authenticated) {
              return HomeScreen(
                user: state.user,
              );
            } else if (state is Unauthenticated) {
              return LoginScreen();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
