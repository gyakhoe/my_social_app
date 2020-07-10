import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_social_app/post/data/models/post.dart';
import 'package:my_social_app/post/data/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  PostBloc({@required PostRepository postRepository})
      : assert(postRepository != null),
        _postRepository = postRepository,
        super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostStarted) {
      yield* _mapPostStartedToState();
    }
  }

  Stream<PostState> _mapPostStartedToState() async* {
    List<Post> posts = await _postRepository.fetchPost();
    if (posts != null) {
      yield PostLoadSuccess(posts);
    } else {
      yield PostLoadFailure();
    }
  }
}
