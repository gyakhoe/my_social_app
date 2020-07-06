import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/authentication/bloc/authentication_bloc.dart';
import 'package:my_social_app/common/observers/app_bloc_obeserver.dart';
import 'package:my_social_app/home_screen.dart';
import 'package:my_social_app/login/layout/login_screen.dart';
import 'package:my_social_app/user/data/repositories/user_repository.dart';

import 'common/layout/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;
  const App({Key key, UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: _userRepository)
        ..add(AuthenticationStarted()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Social App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: _buildWidgetBasedOnState,
        ),
      ),
    );
  }

  Widget _buildWidgetBasedOnState(context, state) {
    if (state is AuthenticationInitial) {
      return SplashScreen();
    }

    if (state is AuthenticationSuccess) {
      return HomeScreen(
        name: state.displayName,
      );
    }

    if (state is AuthenticationFailure) {
      return LoginScreen(
        userRepository: _userRepository,
      );
    }
    return Container();
  }
}
