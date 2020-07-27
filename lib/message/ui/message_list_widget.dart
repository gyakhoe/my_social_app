import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/chat/data/models/chat.dart';
import 'package:my_social_app/message/bloc/message_bloc.dart';
import 'package:my_social_app/message/data/models/message.dart';
import 'package:my_social_app/user/data/models/user.dart';

class MessageListWidget extends StatefulWidget {
  final Chat chat;
  final User currentUser;

  const MessageListWidget({
    Key key,
    this.chat,
    this.currentUser,
  }) : super(key: key);

  @override
  _MessageListWidgetState createState() => _MessageListWidgetState();
}

class _MessageListWidgetState extends State<MessageListWidget> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          if (state is MessageInitial) {
            BlocProvider.of<MessageBloc>(context)
                .add(MessageLoadRequested(widget.chat.id));
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
                controller: _controller,
                shrinkWrap: true,
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  Message message = messages.elementAt(index);
                  return ListTile(
                    title: isMessageSendByMe(widget.currentUser.uid, message)
                        ? senderWidget(
                            message.content,
                            Colors.grey[700],
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
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
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
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[400])),
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
