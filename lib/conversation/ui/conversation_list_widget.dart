import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/chat/bloc/chat_bloc.dart';
import 'package:my_social_app/conversation/data/model/conversation.dart';

class ConversationListWidget extends StatelessWidget {
  final List<Conversation> conversations;

  const ConversationListWidget({Key key, this.conversations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          Conversation conversation = conversations.elementAt(index);
          return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(conversation.receiver.photoUrl),
              ),
              title: Text(
                conversation.receiver.displayName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                BlocProvider.of<ChatBloc>(context)
                  ..add(
                    ChatWithIdPressed(conversation.chatId),
                  );
              });
        },
      ),
    );
  }
}
