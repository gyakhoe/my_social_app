import 'dart:convert';

import 'package:flutter/foundation.dart';

class Post {
  final String photoUrl;
  final String caption;
  final String creationDateTime;
  final String userId;
  final String userName;
  final String userEmail;
  final String userPhotoUrl;
  Post({
    @required this.photoUrl,
    @required this.caption,
    @required this.creationDateTime,
    @required this.userId,
    @required this.userName,
    @required this.userEmail,
    @required this.userPhotoUrl,
  });

  Post copyWith({
    String photoUrl,
    String caption,
    String creationDateTime,
    String userId,
    String userName,
    String userEmail,
    String userPhotoUrl,
  }) {
    return Post(
      photoUrl: photoUrl ?? this.photoUrl,
      caption: caption ?? this.caption,
      creationDateTime: creationDateTime ?? this.creationDateTime,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userPhotoUrl: userPhotoUrl ?? this.userPhotoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'photoUrl': photoUrl,
      'caption': caption,
      'creationDateTime': creationDateTime,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPhotoUrl': userPhotoUrl,
    };
  }

  static Post fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Post(
      photoUrl: map['photoUrl'],
      caption: map['caption'],
      creationDateTime: map['creationDateTime'],
      userId: map['userId'],
      userName: map['userName'],
      userEmail: map['userEmail'],
      userPhotoUrl: map['userPhotoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  static Post fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(photoUrl: $photoUrl, caption: $caption, creationDateTime: $creationDateTime, userId: $userId, userName: $userName, userEmail: $userEmail, userPhotoUrl: $userPhotoUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Post &&
        o.photoUrl == photoUrl &&
        o.caption == caption &&
        o.creationDateTime == creationDateTime &&
        o.userId == userId &&
        o.userName == userName &&
        o.userEmail == userEmail &&
        o.userPhotoUrl == userPhotoUrl;
  }

  @override
  int get hashCode {
    return photoUrl.hashCode ^
        caption.hashCode ^
        creationDateTime.hashCode ^
        userId.hashCode ^
        userName.hashCode ^
        userEmail.hashCode ^
        userPhotoUrl.hashCode;
  }
}
