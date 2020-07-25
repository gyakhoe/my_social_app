import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_social_app/chat/data/models/chat.dart';
import 'package:my_social_app/common/strings.dart';
import 'package:my_social_app/message/data/models/message.dart';
import 'package:my_social_app/message/data/repositories/merssage_repo.dart';
import 'package:my_social_app/user/data/models/user.dart';
import 'package:my_social_app/user/data/repositories/user_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final UserRepository _userRepository;
  final MessageRepo _messageRepo;

  StreamSubscription messageSubscription;

  MessageBloc({
    @required UserRepository userRepository,
    @required MessageRepo messageRepo,
  })  : assert(userRepository != null),
        assert(messageRepo != null),
        _userRepository = userRepository,
        _messageRepo = messageRepo,
        super(MessageInitial());

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    if (event is MessageTextSent) {
      yield* _mapMessageTextSentToState(event);
    }

    if (event is MessageLoadRequested) {
      yield* _maptMessageLoadRequestedToState(event);
    }

    if (event is MessageLoaded) {
      yield* _messageLoadedToState(event);
    }
  }

  Stream<MessageState> _mapMessageTextSentToState(
      MessageTextSent event) async* {
    yield MessageLoadingInProgress();
    final User currentUser = await _userRepository.getUser();
    final message = Message(
      content: event.messageText,
      receiverId: event.chatDetail.creator.uid != currentUser.uid
          ? event.chatDetail.creator.uid
          : event.chatDetail.participent.uid,
      senderId: currentUser.uid,
      timeStamp: DateTime.now(),
    );

    final response = await _messageRepo.uploadNewMessage(
        chatId: event.chatDetail.id, message: message);

    if (actionMessageSuccess == response) {
      yield MessageSendingSuccess();
    } else {
      yield MessageSendingFailure();
    }
  }

  Stream<MessageState> _maptMessageLoadRequestedToState(
      MessageLoadRequested event) async* {
    print('we are here.. ');

    messageSubscription?.cancel();
    messageSubscription =
        _messageRepo.fetchMessages(event.chatId).listen((messages) {
      print('we are here in stream event');

      add(MessageLoaded(messages));
    });
  }

  Stream<MessageState> _messageLoadedToState(MessageLoaded event) async* {
    yield MessageLoadingInProgress();
    yield MessageLoadingSuccess(event.messages);
  }

  @override
  Future<void> close() {
    messageSubscription?.cancel();
    return super.close();
  }
}
