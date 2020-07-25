part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchSelected extends SearchEvent {
  @override
  List<Object> get props => [];
}

class SearchTextEntered extends SearchEvent {
  final String enteredText;
  SearchTextEntered(this.enteredText);
  @override
  List<Object> get props => [enteredText];
}

class SearchCancelled extends SearchEvent {
  @override
  List<Object> get props => [];
}
