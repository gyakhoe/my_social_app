import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/post/bloc/post_bloc.dart';
import 'package:my_social_app/post/data/repositories/image_repository.dart';
import 'package:my_social_app/post/data/repositories/post_repository.dart';
import 'package:my_social_app/profile/layout/profile_page.dart';

class ProfileProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ImageRepository _imageRepository = ImageRepository();
    final PostRepository _postRepository = PostRepository(
      imageRepository: _imageRepository,
    );
    return BlocProvider(
      create: (context) => PostBloc(postRepository: _postRepository),
      child: ProfilePage(),
    );
  }
}
