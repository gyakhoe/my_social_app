import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/login/bloc/login_bloc.dart';
import 'package:my_social_app/login/layout/widgets/login_page.dart';

import 'package:my_social_app/user/data/repositories/user_repository.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;
  const LoginScreen({
    Key key,
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginPage(),
      ),
    );
  }
}
