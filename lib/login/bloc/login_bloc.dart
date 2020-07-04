import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_social_app/user/data/models/user.dart';
import 'package:my_social_app/user/data/repositories/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginFromGooglePressed) {
      yield* _mapLoginFromGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginFromGooglePressedToState() async* {
    User user = await _userRepository.signInWithGoogle();
    if (user != null) {
      yield LoginSuccess(user);
    } else {
      yield LoginFailure();
    }
  }
}
