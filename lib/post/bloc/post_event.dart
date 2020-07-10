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
