import 'dart:convert';

class Message {
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timeStamp;

  Message({
    this.senderId,
    this.receiverId,
    this.content,
    this.timeStamp,
  });

  Message copyWith({
    String senderId,
    String receiverId,
    String content,
    DateTime timeStamp,
  }) {
    return Message(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'timeStamp': timeStamp?.millisecondsSinceEpoch,
    };
  }

  static Message fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Message(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      content: map['content'],
      timeStamp: DateTime.fromMillisecondsSinceEpoch(map['timeStamp']),
    );
  }

  String toJson() => json.encode(toMap());

  static Message fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(senderId: $senderId, receiverId: $receiverId, content: $content, timeStamp: $timeStamp)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Message &&
        o.senderId == senderId &&
        o.receiverId == receiverId &&
        o.content == content &&
        o.timeStamp == timeStamp;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        receiverId.hashCode ^
        content.hashCode ^
        timeStamp.hashCode;
  }
}
