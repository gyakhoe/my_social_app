import 'package:flutter/material.dart';
import 'package:my_social_app/common/utils/date_utilities.dart';

import 'package:my_social_app/post/data/models/post.dart';

class PostWidget extends StatelessWidget {
  final Post _post;
  const PostWidget({Key key, Post post})
      : assert(post != null),
        _post = post,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildPostheader(),
              _buildPostImage(),
              _buildCaption(),
              _buildActionButton(),
            ],
          )),
    );
  }

  _buildPostheader() {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: CircleAvatar(
              backgroundImage: NetworkImage(_post.userPhotoUrl),
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  _post.userEmail,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ),
          Expanded(
            flex: 1,
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }

  _buildPostImage() {
    return Expanded(
      flex: 7,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: FadeInImage(
          placeholder: AssetImage('assets/images/Curve-Loading.gif'),
          image: NetworkImage(_post.photoUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildCaption() {
    return Expanded(
        flex: 1,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: _post.userName,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' ${_post.caption}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                    'Uploaded ${DateUtilities.compareIsoStringWithCurrentDateInMinutes(isoDateString: _post.creationDateTime)} minutes ago.'),
              ),
            ]));
  }

  _buildActionButton() {
    return Expanded(
      flex: 1,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.comment),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
