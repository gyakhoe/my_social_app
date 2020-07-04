part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSubmitting extends LoginState {
  @override
  String toString() {
    return 'Login Submitting';
  }

  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess(this.user);

  @override
  String toString() {
    return 'Login Success';
  }

  @override
  List<Object> get props => [];
}

class LoginFailure extends LoginState {
  @override
  String toString() {
    return 'Login Failure';
  }

  @override
  List<Object> get props => [];
}
