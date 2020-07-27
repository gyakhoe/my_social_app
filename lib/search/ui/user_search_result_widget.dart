import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/chat/bloc/chat_bloc.dart';
import 'package:my_social_app/search/bloc/search_bloc.dart';

class UserSearchResultWidget extends StatefulWidget {
  @override
  _UserSearchResultWidgetState createState() => _UserSearchResultWidgetState();
}

class _UserSearchResultWidgetState extends State<UserSearchResultWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return Container();
        } else if (state is SearchDisplaySuccess) {
          final users = state.users;
          if (users.isEmpty) {
            print('Users length is empty');
            return _buildTempResultWidget(
                child: Text('No users exist. Invite your friends to join in.'));
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.users.elementAt(index).displayName),
                  onTap: () => BlocProvider.of<ChatBloc>(context)
                    ..add(
                      ChatWithUserPressed(
                        receiver: state.users.elementAt(index),
                      ),
                    ),
                );
              });
        } else if (state is SearchDisplayLoading) {
          return _buildTempResultWidget(child: LinearProgressIndicator());
        } else if (state is SearchDisplayFailure) {
          return _buildTempResultWidget(child: Text('Unable to find users.'));
        } else {
          return _buildTempResultWidget(
              child: Text(
                  'Please type username in search box to start the search'));
        }
      },
    );
  }

  _buildTempResultWidget({Widget child}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: EdgeInsets.all(5),
      child: Center(child: child),
    );
  }
}
