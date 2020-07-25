part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchTextEntering extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchDisplaySuccess extends SearchState {
  final List<User> users;
  SearchDisplaySuccess(this.users);
  @override
  List<Object> get props => [users];
}

class SearchDisplayLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchDisplayFailure extends SearchState {
  final String failureMessage;
  SearchDisplayFailure(this.failureMessage);
  @override
  List<Object> get props => [failureMessage];
}
