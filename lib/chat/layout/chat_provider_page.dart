import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/chat/bloc/chat_bloc.dart';
import 'package:my_social_app/chat/data/repositories/chat_repository.dart';
import 'package:my_social_app/chat/layout/chat_page.dart';
import 'package:my_social_app/conversation/bloc/conversation_bloc.dart';
import 'package:my_social_app/conversation/data/repositories/conversation_repository.dart';
import 'package:my_social_app/message/bloc/message_bloc.dart';
import 'package:my_social_app/message/data/repositories/merssage_repo.dart';
import 'package:my_social_app/search/bloc/search_bloc.dart';
import 'package:my_social_app/search/data/repositories/search_repository.dart';
import 'package:my_social_app/user/data/repositories/user_repository.dart';

class ChatProviderPage extends StatelessWidget {
  final SearchRepository _searchRepository = SearchRepository();
  final ChatRepository _chatRepository = ChatRepository();
  final UserRepository _userRepository = UserRepository();
  final ConversationRepository _conversationRepository =
      ConversationRepository();

  final MessageRepo _messageRepo = MessageRepo();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => SearchBloc(
              searchRepository: _searchRepository,
              userRepository: _userRepository),
        ),
        BlocProvider<ChatBloc>(
          create: (BuildContext context) => ChatBloc(
              chatRepository: _chatRepository, userRepository: _userRepository),
        ),
        BlocProvider<ConversationBloc>(
          create: (BuildContext context) => ConversationBloc(
              conversationRepository: _conversationRepository,
              userRepository: _userRepository),
        ),
        BlocProvider<MessageBloc>(
          create: (BuildContext context) => MessageBloc(
            messageRepo: _messageRepo,
            userRepository: _userRepository,
          ),
        ),
      ],
      child: ChatPage(),
    );
  }
}
