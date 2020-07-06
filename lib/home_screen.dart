import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/authentication/bloc/authentication_bloc.dart';
import 'package:my_social_app/user/data/models/user.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({
    Key key,
    @required this.user,
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
        child: Column(
          children: <Widget>[
            Text(user.uid),
            Text(user.email),
            Text(user.displayName),
            Text(user.photoUrl),
          ],
        ),
      ),
    );
  }
}
