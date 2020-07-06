part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  final String name;

  LoginSuccess(this.name);

  @override
  String toString() => 'Loggin Success';
  @override
  List<Object> get props => [];
}

class LoginFailure extends LoginState {
  @override
  String toString() => 'Loggin Failure';
  @override
  List<Object> get props => [];
}

class LoginIsSubmitting extends LoginState {
  @override
  String toString() => 'Loggin LoginSubmitting';
  @override
  List<Object> get props => [];
}
