import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/common/layout/custom_app_bar.dart';
import 'package:my_social_app/post/bloc/post_bloc.dart';

class PostAddScreen extends StatelessWidget {
  final File _selectedImage;
  const PostAddScreen({
    Key key,
    File selectedImage,
  })  : assert(selectedImage != null),
        _selectedImage = selectedImage,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController captionController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(
        leading: FlatButton(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            BlocProvider.of<PostBloc>(context).add(PostAddCancelled());
            Navigator.pop(context);
          },
        ),
        title: 'Add Post',
        trailing: FlatButton(
          child: Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            final caption = captionController.text ?? '';
            BlocProvider.of<PostBloc>(context).add(
              PostSubmitPressed(
                caption: caption,
                image: _selectedImage,
              ),
            );
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                color: Colors.pink,
                child: Image.file(
                  _selectedImage,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                onSubmitted: (value) => captionController.text,
                decoration: InputDecoration(
                  hintText: 'Caption',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
