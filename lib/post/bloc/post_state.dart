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
