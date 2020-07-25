import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_social_app/search/data/repositories/search_repository.dart';
import 'package:my_social_app/user/data/models/user.dart';
import 'package:my_social_app/user/data/repositories/user_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _searchRepository;
  final UserRepository _userRepository;
  SearchBloc({
    @required SearchRepository searchRepository,
    @required UserRepository userRepository,
  })  : assert(searchRepository != null),
        _userRepository = userRepository,
        _searchRepository = searchRepository,
        super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchSelected) {
      yield SearchTextEntering();
    }
    if (event is SearchCancelled) {
      yield SearchInitial();
    }

    if (event is SearchTextEntered) {
      yield SearchDisplayLoading();
      List<User> users = await _searchRepository.getAllUsers();
      User currentUser = await _userRepository.getUser();
      users.removeWhere((element) => element.uid == currentUser.uid);
      yield SearchDisplaySuccess(users);
    }
  }
}
