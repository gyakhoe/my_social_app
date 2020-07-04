import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/authentication/bloc/authentication_bloc.dart';
import 'package:my_social_app/user/data/models/user.dart';

class HomeScreen extends StatelessWidget {
  final User _user;

  HomeScreen({@required User user})
      : assert(user != null),
        _user = user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)..add(LoggedOut());
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(_user.name),
              Text(_user.uid),
              Text(_user.email),
              Text(_user.photoUrl),
            ],
          ),
        ));
  }
}
