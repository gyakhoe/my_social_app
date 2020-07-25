import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/chat/data/models/chat.dart';
import 'package:my_social_app/message/bloc/message_bloc.dart';
import 'package:my_social_app/message/data/models/message.dart';
import 'package:my_social_app/user/data/models/user.dart';

class MessageListWidget extends StatelessWidget {
  final Chat chat;
  final User currentUser;

  const MessageListWidget({
    Key key,
    this.chat,
    this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          if (state is MessageInitial) {
            BlocProvider.of<MessageBloc>(context)
                .add(MessageLoadRequested(chat.id));
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MessageLoadingSuccess) {
            List<Message> messages = state.messages;
            messages = messages.reversed.toList();
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  Message message = messages.elementAt(index);
                  return ListTile(
                    title: isMessageSendByMe(currentUser.uid, message)
                        ? senderWidget(
                            message.content,
                            Colors.grey[500],
                          )
                        : receiverWidget(
                            message.content, Theme.of(context).primaryColor),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  bool isMessageSendByMe(String myId, Message message) =>
      message.senderId == myId ? true : false;

  Widget senderWidget(String messageText, Color color) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          messageText,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget receiverWidget(String messageText, Color color) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          messageText,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
