import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/authentication/bloc/authentication_bloc.dart';
import 'package:my_social_app/post/bloc/post_bloc.dart';
import 'package:my_social_app/post/data/models/post.dart';
import 'package:my_social_app/user/data/models/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is AuthenticationSuccess) {
          final User user = state.user;
          return Column(
            children: <Widget>[
              _buildUserDetail(user, context),
              _buildPostGrid(user, context),
            ],
          );
        } else {
          return Center(
            child: Text('It seems you haved logged out. Please login again'),
          );
        }
      }),
    );
  }

  Widget _buildPostGrid(User user, BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) => _mapPostStateToWidget(context, state, user),
    );
  }

  Widget _mapPostStateToWidget(context, state, user) {
    if (state is PostInitial) {
      BlocProvider.of<PostBloc>(context).add(PostStarted());
      return Expanded(
        child: Center(
          child: Text('No Post is loaded yet.'),
        ),
      );
    }

    if (state is PostLoadInProgress) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    }

    if (state is PostLoadFailure) {
      return Expanded(child: Center(child: Text('Post failed to Load')));
    }

    if (state is PostLoadSuccess) {
      List<Post> posts = state.posts;
      posts.removeWhere((element) => element.userId != user.uid);
      return Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 2,
          ),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            Post post = posts.elementAt(index);
            return Image(
              fit: BoxFit.cover,
              image: NetworkImage(post.photoUrl),
            );
          },
        ),
      );
    }

    return Container();
  }

  Widget _buildUserDetail(User user, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.photoUrl),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildInfoDetail(
                      lable: 'Name',
                      data: user.displayName,
                      screenWidth: MediaQuery.of(context).size.width * 0.6),
                  _buildInfoDetail(
                      lable: 'email',
                      data: user.email,
                      screenWidth: MediaQuery.of(context).size.width * 0.6),
                  _buildInfoDetail(
                    lable: 'UID: ',
                    data:
                        'XXXXX-${user.uid.substring(user.uid.length - 5, user.uid.length)}',
                    screenWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoDetail(
      {@required String lable,
      @required String data,
      @required double screenWidth}) {
    return Container(
      width: screenWidth,
      child: Row(
        children: <Widget>[
          Expanded(flex: 2, child: Text(lable)),
          Expanded(
            flex: 8,
            child: Text(
              data,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
