part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class PostStarted extends PostEvent {
  @override
  String toString() => 'Post Started';
  @override
  List<Object> get props => [];
}

class PostAddPressed extends PostEvent {
  @override
  String toString() => 'PostAddPressed';
  @override
  List<Object> get props => [];
}

class PostAddCancelled extends PostEvent {
  @override
  String toString() => 'PostAddCancelled';
  @override
  List<Object> get props => [];
}

class PostSubmitPressed extends PostEvent {
  final File image;

  final String caption;
  PostSubmitPressed({
    @required this.caption,
    @required this.image,
  });

  @override
  String toString() => 'PostSubmitPressed';
  @override
  List<Object> get props => [caption];
}
