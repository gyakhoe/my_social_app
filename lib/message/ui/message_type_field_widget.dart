import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/chat/data/models/chat.dart';
import 'package:my_social_app/message/bloc/message_bloc.dart';

class MessageTypeFieldWidget extends StatefulWidget {
  final Chat chatDetail;

  const MessageTypeFieldWidget({Key key, @required this.chatDetail})
      : super(key: key);

  @override
  _MessageTypeFieldWidgetState createState() => _MessageTypeFieldWidgetState();
}

class _MessageTypeFieldWidgetState extends State<MessageTypeFieldWidget> {
  TextEditingController messageTextController;

  @override
  void initState() {
    messageTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.teal,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: messageTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                BlocProvider.of<MessageBloc>(context).add(MessageTextSent(
                    chatDetail: widget.chatDetail,
                    messageText: messageTextController.text));

                setState(() {
                  messageTextController.clear();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
