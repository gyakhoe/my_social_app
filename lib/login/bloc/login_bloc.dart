import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_social_app/app_firebase/data/repositories/firebase_repository.dart';
import 'package:my_social_app/user/data/repositories/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  final FirebaseRepository _firebaseRepository;
  LoginBloc({
    @required UserRepository userRepository,
    @required FirebaseRepository firebaseRepository,
  })  : assert(userRepository != null),
        assert(firebaseRepository != null),
        _userRepository = userRepository,
        _firebaseRepository = firebaseRepository,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      yield LoginIsSubmitting();
      var user = await _userRepository.signInWithGoogle();
      _firebaseRepository.uploadUserData(user);
      yield LoginSuccess(user.displayName);
    } catch (_) {
      yield LoginFailure();
    }
  }
}
