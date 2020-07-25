import 'package:flutter/foundation.dart';
import 'package:my_social_app/message/data/models/message.dart';
import 'package:my_social_app/message/data/repositories/message_firebase_repo.dart';

class MessageRepo {
  MessageFirebaseRepo messageFirebaseRepo = MessageFirebaseRepo();
  Future<String> uploadNewMessage({
    @required String chatId,
    @required Message message,
  }) async {
    return await messageFirebaseRepo.setNewMessage(
        chatId: chatId, message: message);
  }

  Stream<List<Message>> fetchMessages(String chatId) {
    return messageFirebaseRepo.getMessages(chatId: chatId);
  }
}
