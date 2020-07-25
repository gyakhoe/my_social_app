import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_social_app/conversation/data/model/conversation.dart';
import 'package:my_social_app/conversation/data/repositories/conversation_repository.dart';
import 'package:my_social_app/user/data/models/user.dart';
import 'package:my_social_app/user/data/repositories/user_repository.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationRepository _conversationRepository;
  final UserRepository _userRepository;
  ConversationBloc({
    @required ConversationRepository conversationRepository,
    @required UserRepository userRepository,
  })  : assert(conversationRepository != null),
        _conversationRepository = conversationRepository,
        _userRepository = userRepository,
        super(ConversationInitial());

  @override
  Stream<ConversationState> mapEventToState(
    ConversationEvent event,
  ) async* {
    if (event is ConverstationListRequested) {
      yield* _mapConversationListRequestedToState(event);
    }
  }

  Stream<ConversationState> _mapConversationListRequestedToState(
      ConverstationListRequested event) async* {
    yield ConversationLoadingInprogress();

    try {
      User user = await _userRepository.getUser();

      List<Conversation> conversations =
          await _conversationRepository.getAllConverstaion(userId: user.uid);
      yield ConversationLoadingSuccess(conversations);
    } catch (exception) {
      yield ConversationLoadingFailure('Failed to Load Conversations');
    }
  }
}
