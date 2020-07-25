import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_social_app/chat/data/models/chat.dart';
import 'package:my_social_app/chat/data/repositories/chat_repository.dart';
import 'package:my_social_app/common/strings.dart';
import 'package:my_social_app/user/data/models/user.dart';
import 'package:my_social_app/user/data/repositories/user_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  final UserRepository _userRepository;
  ChatBloc({
    UserRepository userRepository,
    ChatRepository chatRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        _chatRepository = chatRepository,
        super(ChatInitial());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is ChatWithUserPressed) {
      yield* _mapChatWithUserPressedToState(event);
    }
    if (event is ChatWithIdPressed) {
      yield* _mapChatWithIdPressedToState(event);
    }

    if (event is ChatMessageSent) {}
    if (event is ChatPhotoReceived) {}
    if (event is ChatPhotoSent) {}
    if (event is ChatPhotoReceived) {}
  }

  Stream<ChatState> _mapChatWithUserPressedToState(
    ChatWithUserPressed event,
  ) async* {
    yield ChatUserLoading();

    final User participent = event.receiver;
    final User currentUser = await _userRepository.getUser();
    final List<String> members = [currentUser.uid, participent.uid];

    Chat fetchedChat = await _chatRepository.getChat(members);
    if (fetchedChat != null) {
      print('-------chat found------');
      yield ChatUserSuccess(
        chat: fetchedChat,
        currentUser: currentUser,
      );
    } else {
      print('-------chat not found------');
      final String creationDateTime = DateTime.now().toIso8601String();
      final Chat chat = Chat(
        creationDateTime: creationDateTime,
        creator: currentUser,
        members: members,
        participent: participent,
        id: currentUser.uid + participent.uid,
      );

      final String response = await _chatRepository.createNewChat(chat);
      if (response == actionMessageSuccess) {
        yield ChatUserSuccess(chat: chat, currentUser: currentUser);
      } else {
        yield ChatUserFailure();
      }
    }
  }

  Stream<ChatState> _mapChatWithIdPressedToState(
      ChatWithIdPressed event) async* {
    final Chat chat = await _chatRepository.getChatWithId(event.chatId);
    final User currentUser = await _userRepository.getUser();
    yield chat != null
        ? ChatUserSuccess(
            chat: chat,
            currentUser: currentUser,
          )
        : ChatUserFailure();
  }
}
