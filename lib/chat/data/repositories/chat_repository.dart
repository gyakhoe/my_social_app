import 'package:my_social_app/app_firebase/data/repositories/firebase_repository.dart';
import 'package:my_social_app/chat/data/models/chat.dart';

class ChatRepository {
  FirebaseRepository _firebaseRepository = FirebaseRepository();
  Future<String> createNewChat(Chat chat) async {
    return await _firebaseRepository.createNewChat(chat);
  }

  Future<List<Chat>> getAvailableChats(String userId) async {
    return await _firebaseRepository.fetchAvialableChats(userId);
  }

  Future<Chat> getChat(List<String> members) async {
    return await _firebaseRepository.fetchChat(members: members);
  }

  Future<Chat> getChatWithId(String chatId) async {
    return await _firebaseRepository.fetchChatById(chatId);
  }
}
