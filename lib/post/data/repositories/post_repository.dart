import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:my_social_app/app_firebase/data/repositories/firebase_repository.dart';
import 'package:my_social_app/post/data/models/post.dart';
import 'package:my_social_app/post/data/repositories/image_repository.dart';

class PostRepository {
  final ImageRepository _imageRepository;

  PostRepository({@required ImageRepository imageRepository})
      : assert(imageRepository != null),
        _imageRepository = imageRepository;

  Future<File> getImage() async {
    File selectedImage = await _imageRepository.selectImage();
    return selectedImage;
  }

  Future<String> uploadPhotoIntoFireStore({@required File image}) async {
    FirebaseRepository firebaseRepository = FirebaseRepository();
    String downloadUrl = await firebaseRepository.uploadPostImage(image);
    return downloadUrl;
  }

  Future<String> submitPostIntoFirebase({@required Post post}) async {
    FirebaseRepository firebaseRepository = FirebaseRepository();
    String response = await firebaseRepository.uploadPostData(post);
    return response;
  }

  Future<List<Post>> fetchPost() async {
    FirebaseRepository firebaseRepository = FirebaseRepository();
    List<Post> posts = await firebaseRepository.fetchPosts();
    return posts.toList();
  }
}
