import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/app_firebase/data/repositories/firebase_repository.dart';
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
  final FirebaseRepository firebaseRepository = FirebaseRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: App(
        userRepository: userRepository,
        firebaseRepository: firebaseRepository,
      ),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;
  final FirebaseRepository _firebaseRepository;
  const App({
    Key key,
    @required UserRepository userRepository,
    @required FirebaseRepository firebaseRepository,
  })  : assert(userRepository != null),
        assert(firebaseRepository != null),
        _userRepository = userRepository,
        _firebaseRepository = firebaseRepository,
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
        user: state.user,
      );
    }

    if (state is AuthenticationFailure) {
      return LoginScreen(
        userRepository: _userRepository,
        firebaseRepository: _firebaseRepository,
      );
    }
    return Container();
  }
}
