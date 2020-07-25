import 'package:my_social_app/chat/data/models/chat.dart';

import 'package:my_social_app/chat/data/repositories/chat_repository.dart';
import 'package:my_social_app/conversation/data/model/conversation.dart';

class ConversationRepository {
  /// It will return Future<List<Converstation>> on the basis of userID provided
  Future<List<Conversation>> getAllConverstaion({String userId}) async {
    List<Chat> chats = await ChatRepository().getAvailableChats(userId);
    final List<Conversation> converstations = List<Conversation>();
    for (final chat in chats) {
      Conversation conversation = Conversation(
        chatId: chat.id,
        hasUnreadMessage: false,
        lastMessage: 'Test message',
        receiver:
            chat.participent.uid == userId ? chat.creator : chat.participent,
        unreadMessageCount: 0,
      );
      converstations.add(conversation);
    }
    return converstations;
  }
}
