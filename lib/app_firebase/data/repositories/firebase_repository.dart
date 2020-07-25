import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_social_app/chat/data/models/chat.dart';
import 'package:my_social_app/common/strings.dart';
import 'package:my_social_app/post/data/models/post.dart';
import 'package:my_social_app/user/data/models/user.dart';

class FirebaseRepository {
  Firestore _firestore = Firestore.instance;

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser() != null ? true : false;
  }

  Future<String> uploadUserData(User user) async {
    DocumentReference userDocRef =
        _firestore.collection('users').document(user.uid);
    try {
      await userDocRef.setData(user.toMap());
      return actionMessageSuccess;
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
        _firestore.collection('posts').document();
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
    QuerySnapshot snapshot = await _firestore
        .collection('posts')
        .orderBy('creationDateTime', descending: true)
        .getDocuments();
    List<Post> posts =
        snapshot.documents.map((e) => Post.fromMap(e.data)).toList();
    for (Post post in posts) {
      print(post.toString());
    }
    return posts;
  }

  Future<List<User>> fetchUsers() async {
    QuerySnapshot snapshot =
        await _firestore.collection('users').getDocuments();
    List<User> users =
        snapshot.documents.map((e) => User.fromMap(e.data)).toList();
    return users;
  }

  Future<String> createNewChat(Chat chat) async {
    DocumentReference chatReference =
        _firestore.collection('chats').document(chat.id);
    try {
      final bool hasOldChat = await hasChat(members: chat.members);
      if (hasOldChat) {
        print('There is already data available, so setting is ignored');
        return actionMessageSuccess;
      }
      await chatReference.setData(chat.toMap());
      return actionMessageSuccess;
    } catch (exception) {
      print('Exception occured while createing new chat');
      return actionMessageError;
    }
  }

  Future<bool> hasChat({List<String> members}) async {
    DocumentSnapshot snapshot = await _firestore
        .collection('chats')
        .document(members.elementAt(0) + members.elementAt(1))
        .get();

    if (snapshot.data != null) {
      return true;
    } else {
      print('Searched in revered chatID in hasChat');
      snapshot = await _firestore
          .collection('chats')
          .document(members.elementAt(1) + members.elementAt(0))
          .get();

      if (snapshot.data != null) {
        print('Chat found in reverse order in hasChat');
        return true;
      } else {
        print('Chat not found in reveresed order in hasChat');
        return false;
      }
    }
  }

  Future<Chat> fetchChat({List<String> members}) async {
    DocumentSnapshot snapshot = await _firestore
        .collection('chats')
        .document(members.elementAt(0) + members.elementAt(1))
        .get();

    if (snapshot.data != null) {
      return Chat.fromMap(snapshot.data);
    } else {
      print('Searched in revered chatID in fetchChat');
      snapshot = await _firestore
          .collection('chats')
          .document(members.elementAt(1) + members.elementAt(0))
          .get();

      if (snapshot.data != null) {
        print('Chat found in reverse order in fetchChat');
        return Chat.fromMap(snapshot.data);
      } else {
        print('Chat not found in reveresed order in fetchChat');
        return null;
      }
    }
  }

  Future<Chat> fetchChatById(String chatId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('chats').document(chatId).get();

    if (snapshot.data != null) {
      return Chat.fromMap(snapshot.data);
    } else {
      return null;
    }
  }

  Future<List<Chat>> fetchAvialableChats(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('chats')
          .where(
            'members',
            arrayContains: userId,
          )
          .getDocuments();

      List<Chat> chats =
          snapshot.documents.map((e) => Chat.fromMap(e.data)).toList();
      return chats;
    } catch (exception) {
      print(
          'exception occured while searching for avialable searchs ${exception.toString()}');
      return [];
    }
  }
}
