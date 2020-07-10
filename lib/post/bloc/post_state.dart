part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'PostInitial';
}

class PostSelectSuccess extends PostState {
  final File selectedImage;

  PostSelectSuccess({
    @required this.selectedImage,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => 'PostSelectSuccess';
}

class PostSelectCancel extends PostState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'PostSubmitCancle';
}

class PostSelectFailure extends PostState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'PostSubmitFailure';
}

class PostSubmitSuccess extends PostState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'PostSubmitSuccess';
}

class PostSubmitFailure extends PostState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'PostSubmitFailure';
}

class PostSubmitInProgress extends PostState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'PostSubmitInProgress';
}

class PostLoadInProgress extends PostState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'PostLoadInProgress';
}

class PostLoadSuccess extends PostState {
  final List<Post> posts;
  PostLoadSuccess(this.posts);
  @override
  List<Object> get props => [posts];

  @override
  String toString() => 'PostLoadSuccess ${posts.length}';
}

class PostLoadFailure extends PostState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'PostLoadFailure';
}
