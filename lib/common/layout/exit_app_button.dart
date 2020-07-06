import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/authentication/bloc/authentication_bloc.dart';

class ExitAppButton extends StatelessWidget {
  const ExitAppButton();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.exit_to_app,
        color: Colors.white,
      ),
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context)
          ..add(AuthenticationLoggedOut());
      },
    );
  }
}
