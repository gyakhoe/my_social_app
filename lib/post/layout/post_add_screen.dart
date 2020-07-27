import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/common/layout/custom_app_bar.dart';
import 'package:my_social_app/post/bloc/addpost_bloc.dart';

class PostAddScreen extends StatefulWidget {
  final File _selectedImage;
  const PostAddScreen({
    Key key,
    File selectedImage,
  })  : assert(selectedImage != null),
        _selectedImage = selectedImage,
        super(key: key);

  @override
  _PostAddScreenState createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  TextEditingController captionController;

  @override
  void initState() {
    super.initState();
    captionController = TextEditingController();
  }

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            BlocProvider.of<AddpostBloc>(context).add(PostAddCancelled());
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
            BlocProvider.of<AddpostBloc>(context).add(
              PostSubmitPressed(
                caption: caption,
                image: widget._selectedImage,
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
                child: Image.file(
                  widget._selectedImage,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: captionController,
                minLines: 1,
                maxLines: 5,
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
