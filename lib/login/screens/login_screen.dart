import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_social_app/authentication/bloc/authentication_bloc.dart';
import 'package:my_social_app/login/bloc/login_bloc.dart';
import 'package:my_social_app/user/data/repositories/user_repository.dart';

import '../../home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserRepository _userRepository;
  LoginBloc _loginBloc;

  @override
  void initState() {
    _userRepository = UserRepository();
    _loginBloc = LoginBloc(userRepository: _userRepository);
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginInitial) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.pink,
                        onPressed: () {
                          _loginBloc.add(LoginFromGooglePressed());
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              ),
                              Text('Login with Google')
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is LoginSuccess) {
                  return HomeScreen(
                    user: state.user,
                  );
                } else {
                  return Container(
                    child: Text('Unknown State. $state'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
