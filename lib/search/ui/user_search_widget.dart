import 'package:flutter/material.dart';
import 'package:my_social_app/search/ui/user_search_field_widget.dart';
import 'package:my_social_app/search/ui/user_search_result_widget.dart';

class ChatSearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserSearchFieldWidget(),
        UserSearchResultWidget(),
      ],
    );
  }
}
