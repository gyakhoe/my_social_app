import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/chat/bloc/chat_bloc.dart';
import 'package:my_social_app/conversation/ui/conversation_builder_widget.dart';
import 'package:my_social_app/message/bloc/message_bloc.dart';
import 'package:my_social_app/message/ui/message_screen.dart';
import 'package:my_social_app/search/ui/user_search_widget.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatUserSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (newContext) => BlocProvider.value(
                        value: BlocProvider.of<MessageBloc>(context),
                        child: MessageScreen(
                          chatDetail: state.chat,
                          currentUser: state.currentUser,
                        ),
                      )));
        }
      },
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            ChatSearchWidget(),
            ConversationBuilderWidget(),
          ],
        ),
      ),
    );
  }
}
