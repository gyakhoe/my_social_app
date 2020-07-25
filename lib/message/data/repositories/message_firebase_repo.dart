import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:my_social_app/common/strings.dart';
import 'package:my_social_app/common/utils/user_utilities.dart';
import 'package:my_social_app/message/data/models/message.dart';
import 'package:my_social_app/user/data/models/user.dart';

class MessageFirebaseRepo {
  final Firestore _firestore = Firestore.instance;

  Future<User> getCurrentUser() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    return UserUtilities.convertFirebaseUserToUser(firebaseUser: firebaseUser);
  }

  Future<String> setNewMessage({
    @required String chatId,
    @required Message message,
  }) async {
    try {
      DocumentReference reference = _firestore
          .collection('chats')
          .document(chatId)
          .collection('messages')
          .document();
      await reference.setData(message.toMap());
      return actionMessageSuccess;
    } catch (exception) {
      print('Exception occurred while uploading message to firestore');
      return actionMessageError;
    }
  }

  Stream<List<Message>> getMessages({@required String chatId}) {
    Stream<List<Message>> messagesStream = _firestore
        .collection('chats')
        .document(chatId)
        .collection('messages')
        .orderBy('timeStamp')
        .snapshots()
        .map((documents) {
      return documents.documents.map((e) => Message.fromMap(e.data)).toList();
    });
    return messagesStream;
  }
}
