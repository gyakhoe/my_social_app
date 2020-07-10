import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/post/bloc/post_bloc.dart';
import 'package:my_social_app/post/data/repositories/image_repository.dart';
import 'package:my_social_app/post/data/repositories/post_repository.dart';
import 'package:my_social_app/post/layout/post_home_page.dart';

class PostProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //* Providing the required dependencies for PostBloc
    ImageRepository _imageRepository = ImageRepository();
    PostRepository _postRepository =
        PostRepository(imageRepository: _imageRepository);
    return BlocProvider(
      create: (_) => PostBloc(postRepository: _postRepository),
      child: PostHomePage(),
    );
  }
}
