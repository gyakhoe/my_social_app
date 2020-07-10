import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_social_app/common/strings.dart';
import 'package:my_social_app/post/data/models/post.dart';
import 'package:my_social_app/user/data/models/user.dart';

class FirebaseRepository {
  Firestore _firestore = Firestore.instance;

  bool _isLoggedIn() {
    return FirebaseAuth.instance.currentUser() != null ? true : false;
  }

  Future<String> uploadUserData(User user) async {
    DocumentReference userDocRef =
        _firestore.collection('users').document(user.uid);
    try {
      await userDocRef.setData(user.toMap());
      return actionMessageFailure;
    } catch (_) {
      print('Exception occured while storing user data. Returning failure');
      return actionMessageError;
    }
  }

  /// Taking in File and returns the download url if successful
  /// On failure to upload will return failure
  /// On Exception will return error
  Future<String> uploadPostImage(File image) async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    try {
      StorageTaskSnapshot storageTaskSnapshot = await firebaseStorage
          .ref()
          .child('images/post/${DateTime.now()}')
          .putFile(image)
          .onComplete;
      if (storageTaskSnapshot.error == null) {
        final String downloadUrl =
            await storageTaskSnapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        print(
            'Error occured while uploading image to firestorage ${storageTaskSnapshot.error}');
        return actionMessageFailure;
      }
    } catch (exception) {
      print(
          'Exception occurred while uplaoding image to firestorage ${exception.toString()}');
      return actionMessageError;
    }
  }

  Future<String> uploadPostData(Post post) async {
    DocumentReference postDocReference =
        _firestore.collection('post').document();
    try {
      await postDocReference.setData(post.toMap());
      print('Post detail added succesful');
      return actionMessageSuccess;
    } catch (exception) {
      print('Exception occured while storing post details');
      return actionMessageError;
    }
  }

  Future<List<Post>> fetchPosts() async {
    QuerySnapshot snapshot = await _firestore.collection('post').getDocuments();
    List<Post> posts =
        snapshot.documents.map((e) => Post.fromMap(e.data)).toList();
    for (Post post in posts) {
      print(post.toString());
    }
    return posts;
  }
}
