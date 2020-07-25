import 'package:flutter/material.dart';
import 'package:my_social_app/chat/data/models/chat.dart';
import 'package:my_social_app/message/ui/message_list_widget.dart';
import 'package:my_social_app/message/ui/message_type_field_widget.dart';
import 'package:my_social_app/user/data/models/user.dart';

class MessageScreen extends StatelessWidget {
  final User currentUser;
  final Chat chatDetail;

  const MessageScreen({
    Key key,
    @required this.chatDetail,
    @required this.currentUser,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Screen'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 75,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 9,
                child: Container(
                  child: MessageListWidget(
                    chat: chatDetail,
                    currentUser: currentUser,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: MessageTypeFieldWidget(
                  chatDetail: chatDetail,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
