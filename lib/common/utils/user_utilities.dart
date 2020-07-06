import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:my_social_app/user/data/models/user.dart';

class UserUtilities {
  /// Takes in FirebaseUser and return custom User model
  static User convertFirebaseUserToUser({@required FirebaseUser firebaseUser}) {
    return User(
      uid: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      email: firebaseUser.email,
      photoUrl: firebaseUser.photoUrl,
    );
  }
}
