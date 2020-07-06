part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final User user;

  const AuthenticationSuccess(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'AuthenticationSuccess { displayName: $user }';
}

class AuthenticationFailure extends AuthenticationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationFailure';
}
