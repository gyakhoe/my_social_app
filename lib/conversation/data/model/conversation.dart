import 'dart:convert';

import 'package:my_social_app/user/data/models/user.dart';

class Conversation {
  final User receiver;
  final String lastMessage;
  final bool hasUnreadMessage;
  final int unreadMessageCount;
  final String chatId;

  Conversation({
    this.receiver,
    this.lastMessage,
    this.hasUnreadMessage,
    this.unreadMessageCount,
    this.chatId,
  });

  Conversation copyWith({
    User receiver,
    String lastMessage,
    bool hasUnreadMessage,
    int unreadMessageCount,
    String chatId,
  }) {
    return Conversation(
      receiver: receiver ?? this.receiver,
      lastMessage: lastMessage ?? this.lastMessage,
      hasUnreadMessage: hasUnreadMessage ?? this.hasUnreadMessage,
      unreadMessageCount: unreadMessageCount ?? this.unreadMessageCount,
      chatId: chatId ?? this.chatId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'receiver': receiver?.toMap(),
      'lastMessage': lastMessage,
      'hasUnreadMessage': hasUnreadMessage,
      'unreadMessageCount': unreadMessageCount,
      'chatId': chatId,
    };
  }

  static Conversation fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Conversation(
      receiver: User.fromMap(map['receiver']),
      lastMessage: map['lastMessage'],
      hasUnreadMessage: map['hasUnreadMessage'],
      unreadMessageCount: map['unreadMessageCount'],
      chatId: map['chatId'],
    );
  }

  String toJson() => json.encode(toMap());

  static Conversation fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Conversation(receiver: $receiver, lastMessage: $lastMessage, hasUnreadMessage: $hasUnreadMessage, unreadMessageCount: $unreadMessageCount, chatId: $chatId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Conversation &&
        o.receiver == receiver &&
        o.lastMessage == lastMessage &&
        o.hasUnreadMessage == hasUnreadMessage &&
        o.unreadMessageCount == unreadMessageCount &&
        o.chatId == chatId;
  }

  @override
  int get hashCode {
    return receiver.hashCode ^
        lastMessage.hashCode ^
        hasUnreadMessage.hashCode ^
        unreadMessageCount.hashCode ^
        chatId.hashCode;
  }
}
