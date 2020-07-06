import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/authentication/bloc/authentication_bloc.dart';
import 'package:my_social_app/user/data/models/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColorLight,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is AuthenticationSuccess) {
          final User user = state.user;
          return Column(
            children: <Widget>[
              Card(
                elevation: 5,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(user.photoUrl),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildInfoDetail(
                                  lable: 'Name',
                                  data: user.displayName,
                                  screenWidth:
                                      MediaQuery.of(context).size.width * 0.6),
                              _buildInfoDetail(
                                  lable: 'email',
                                  data: user.email,
                                  screenWidth:
                                      MediaQuery.of(context).size.width * 0.6),
                              _buildInfoDetail(
                                lable: 'UID: ',
                                data: user.uid,
                                screenWidth:
                                    MediaQuery.of(context).size.width * 0.6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
