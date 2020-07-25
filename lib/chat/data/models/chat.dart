import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:my_social_app/user/data/models/user.dart';

class Chat {
  final String id;
  final User creator;
  final User participent;
  final List<String> members;
  final String creationDateTime;

  Chat({
    @required this.id,
    @required this.creator,
    @required this.participent,
    @required this.members,
    @required this.creationDateTime,
  });

  Chat copyWith({
    String id,
    User creator,
    User participent,
    List<String> members,
    String creationDateTime,
  }) {
    return Chat(
      id: id ?? this.id,
      creator: creator ?? this.creator,
      participent: participent ?? this.participent,
      members: members ?? this.members,
      creationDateTime: creationDateTime ?? this.creationDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creator': creator?.toMap(),
      'participent': participent?.toMap(),
      'members': members,
      'creationDateTime': creationDateTime,
    };
  }

  static Chat fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Chat(
      id: map['id'],
      creator: User.fromMap(map['creator']),
      participent: User.fromMap(map['participent']),
      members: List<String>.from(map['members']),
      creationDateTime: map['creationDateTime'],
    );
  }

  String toJson() => json.encode(toMap());

  static Chat fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Chat(id: $id, creator: $creator, participent: $participent, members: $members, creationDateTime: $creationDateTime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Chat &&
        o.id == id &&
        o.creator == creator &&
        o.participent == participent &&
        listEquals(o.members, members) &&
        o.creationDateTime == creationDateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        creator.hashCode ^
        participent.hashCode ^
        members.hashCode ^
        creationDateTime.hashCode;
  }
}
