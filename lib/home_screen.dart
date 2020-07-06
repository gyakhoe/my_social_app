import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/authentication/bloc/authentication_bloc.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  const HomeScreen({
    Key key,
    @required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                ..add(AuthenticationLoggedOut());
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome $name'),
      ),
    );
  }
}
