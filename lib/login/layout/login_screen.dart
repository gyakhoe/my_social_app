import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/app_firebase/data/repositories/firebase_repository.dart';
import 'package:my_social_app/login/bloc/login_bloc.dart';
import 'package:my_social_app/login/layout/widgets/login_page.dart';

import 'package:my_social_app/user/data/repositories/user_repository.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final FirebaseRepository _firebaseRepository;

  const LoginScreen(
      {Key key,
      @required UserRepository userRepository,
      @required FirebaseRepository firebaseRepository})
      : assert(userRepository != null),
        assert(firebaseRepository != null),
        _userRepository = userRepository,
        _firebaseRepository = firebaseRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
            userRepository: _userRepository,
            firebaseRepository: _firebaseRepository),
        child: LoginPage(),
      ),
    );
  }
}
