import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/post/bloc/post_bloc.dart';
import 'package:my_social_app/post/layout/post_add_screen.dart';

class PostHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Container(
      height: screen.height,
      width: screen.width,
      child: BlocListener<PostBloc, PostState>(
        listener: _postBlocListener,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<PostBloc>(context).add(PostAddPressed());
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _postBlocListener(context, state) {
    print('listener is called');
    if (state is PostSelectSuccess) {
      print('Post image is selected by user');
      final PostBloc postBloc = BlocProvider.of<PostBloc>(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                value: postBloc,
                child: PostAddScreen(
                  selectedImage: state.selectedImage,
                )),
          ));
    } else if (state is PostSelectCancle) {
      print('User has cancelled post add');
    } else if (state is PostSelectFailure) {
      print('User selection is not avilable');
      showDialog(context: context, child: Text('No image was selected'));
    } else if (state is PostSubmitInProgress) {
      _showDialog(
        context,
        Icon(Icons.av_timer),
        Text('Submitting Post.'),
      );
    } else if (state is PostSubmitFailure) {
      _showDialog(
        context,
        Icon(Icons.error),
        Text('Post submission failed'),
      );
    } else if (state is PostSubmitSuccess) {
      _showDialog(
        context,
        Icon(Icons.ac_unit),
        Text('Post Uplaoded.'),
      );
    } else {
      print('unknown state is called');
      _showDialog(context, Icon(Icons.device_unknown), Text('Upload failed.'));
    }
  }

  _showDialog(context, title, content) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 10),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              title,
              content,
            ],
          ),
          backgroundColor: Colors.blueGrey,
        ),
      );
  }
}
