import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/post/bloc/addpost_bloc.dart';
import 'package:my_social_app/post/bloc/post_bloc.dart';
import 'package:my_social_app/post/layout/post_add_screen.dart';
import 'package:my_social_app/post/layout/widgets/post_widget.dart';

class PostHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    return Container(
      height: screen.height,
      width: screen.width,
      child: BlocListener<AddpostBloc, AddpostState>(
        listener: _postBlocListener,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<PostBloc, PostState>(
                builder: _postBlocBuilder,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<AddpostBloc>(context).add(PostAddPressed());
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
      final addPostBloc = BlocProvider.of<AddpostBloc>(context);
      print('Post image is selected by user');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                value: addPostBloc,
                child: PostAddScreen(
                  selectedImage: state.selectedImage,
                )),
          ));
    } else if (state is PostSelectCancel) {
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
      print('we are here and adding post started');
      BlocProvider.of<PostBloc>(context).add(PostStarted());
      _showDialog(
        context,
        Icon(Icons.ac_unit),
        Text('Post Uplaoded.'),
      );
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

  Widget _postBlocBuilder(context, state) {
    if (state is PostLoadInProgress) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is PostLoadFailure) {
      return Center(child: Text('PostFailed to Load'));
    } else if (state is PostLoadSuccess) {
      return ListView.builder(
          itemCount: state.posts.length,
          itemBuilder: (context, index) => PostWidget(
                post: state.posts.elementAt(index),
              ));
    } else if (state is PostInitial) {
      print('Post state is initial');
      BlocProvider.of<PostBloc>(context)..add(PostStarted());
      return _buildPostInitialLoadIndicator();
    } else {
      BlocProvider.of<PostBloc>(context)..add(PostStarted());
      return Center(child: Text('No State found'));
    }
  }

  Widget _buildPostInitialLoadIndicator() {
    return Center(child: CircularProgressIndicator());
  }
}
