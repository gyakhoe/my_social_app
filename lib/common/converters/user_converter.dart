import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:my_social_app/user/data/models/user.dart';

class UserConverter {
  static User convertFirebaseUserToUser({@required FirebaseUser firebaseUser}) {
    return User(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? 'NA',
        photoUrl: firebaseUser.photoUrl ?? '',
        name: firebaseUser.displayName ?? 'NA');
  }
}
