import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_social_app/common/strings.dart';
import 'package:my_social_app/post/data/models/post.dart';
import 'package:my_social_app/post/data/repositories/post_repository.dart';
import 'package:my_social_app/user/data/repositories/user_repository.dart';

part 'addpost_event.dart';
part 'addpost_state.dart';

class AddpostBloc extends Bloc<AddpostEvent, AddpostState> {
  final PostRepository _postRepository;
  final UserRepository _userRepository;
  AddpostBloc({
    @required PostRepository postRepository,
    @required UserRepository userRepository,
  })  : assert(postRepository != null),
        assert(userRepository != null),
        _postRepository = postRepository,
        _userRepository = userRepository,
        super(AddpostInitial());

  @override
  Stream<AddpostState> mapEventToState(
    AddpostEvent event,
  ) async* {
    if (event is PostAddPressed) {
      yield* _mapPostAddPressedToState();
    } else if (event is PostAddCancelled) {
      yield* _mapPostAddCancelledToState();
    } else if (event is PostSubmitPressed) {
      yield* _mapPostSubmitPressedToState(event);
    }
  }

  Stream<AddpostState> _mapPostAddPressedToState() async* {
    File selectedImage = await _postRepository.getImage();
    yield selectedImage == null
        ? PostSelectFailure()
        : PostSelectSuccess(selectedImage: selectedImage);
  }

  Stream<AddpostState> _mapPostSubmitPressedToState(
      PostSubmitPressed event) async* {
    print('post submit is called');
    yield PostSubmitInProgress();
    final user = await _userRepository.getUser();
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
        userEmail: user.email,
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

  Stream<AddpostState> _mapPostAddCancelledToState() async* {
    yield PostSelectCancel();
  }
}
