import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_social_app/common/strings.dart';
import 'package:my_social_app/post/data/models/post.dart';
import 'package:my_social_app/post/data/repositories/post_repository.dart';
import 'package:my_social_app/user/data/repositories/user_repository.dart';

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
    if (event is PostAddPressed) {
      yield* _mapPostAddPressedToState();
    }
    if (event is PostAddCancelled) {
      yield* _mapPostAddCancelledToState();
    }

    if (event is PostSubmitPressed) {
      yield* _mapPostSubmitPressedToState(event);
    }
  }

  Stream<PostState> _mapPostAddPressedToState() async* {
    File selectedImage = await _postRepository.getImage();
    yield selectedImage == null
        ? PostSelectFailure()
        : PostSelectSuccess(selectedImage: selectedImage);
  }

  Stream<PostState> _mapPostSubmitPressedToState(
      PostSubmitPressed event) async* {
    yield PostSubmitInProgress();
    final user = await UserRepository().getUser();
    String imageDownloadUrl =
        await _postRepository.uploadPhotoIntoFireStore(image: event.image);
    if (imageDownloadUrl != actionMessageError ||
        imageDownloadUrl != actionMessageFailure) {
      Post post = Post(
        caption: event.caption,
        creationDateTime: DateTime.now().toIso8601String(),
        photoUrl: imageDownloadUrl,
        userId: user.uid,
        userName: user.displayName,
        userPhotoUrl: user.photoUrl,
      );

      String response =
          await _postRepository.submitPostIntoFirebase(post: post);
      if (response == actionMessageSuccess) {
        yield PostSubmitSuccess();
      } else {
        yield PostSubmitFailure();
      }
    } else {
      print('Not able to get download URL');
      yield PostSubmitFailure();
    }
  }

  Stream<PostState> _mapPostAddCancelledToState() async* {
    yield PostSelectCancle();
  }
}
