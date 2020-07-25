import 'package:flutter/material.dart';

import 'package:my_social_app/chat/data/models/chat.dart';

class ChatConversationPage extends StatelessWidget {
  final Chat _chatDetail;
  const ChatConversationPage({
    Key key,
    Chat chat,
  })  : assert(chat != null),
        _chatDetail = chat,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_chatDetail.participent.displayName)),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(child: Text('Here we will display Converstaion')),
      ),
    );
  }
}
