import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_social_app/authentication/bloc/authentication_bloc.dart';
import 'package:my_social_app/common/layout/my_social_app_logo.dart';
import 'package:my_social_app/login/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: _loginPageBlocListener,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: _buildLoginWidget(context),
        ),
      ),
    );
  }

  Widget _buildLoginWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          MySocialAppLogo(),
          _buildLoginWithGoogleButton(context),
        ],
      ),
    );
  }

  Widget _buildLoginWithGoogleButton(BuildContext context) {
    return FlatButton(
      color: Theme.of(context).primaryColor,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.google,
              color: Theme.of(context).accentColor,
            ),
            Text(
              'Login with Google',
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
          ],
        ),
      ),
      onPressed: () {
        BlocProvider.of<LoginBloc>(context)..add(LoginWithGooglePressed());
      },
    );
  }

  _loginPageBlocListener(context, state) {
    if (state is LoginFailure) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Login Failure'),
                Icon(Icons.error),
              ],
            ),
            backgroundColor: Colors.red,
          ),
        );
    }

    if (state is LoginIsSubmitting) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Loging In'),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
    }

    if (state is LoginSuccess) {
      BlocProvider.of<AuthenticationBloc>(context)
        ..add(AuthenticationLoggedIn());
    }
  }
}
