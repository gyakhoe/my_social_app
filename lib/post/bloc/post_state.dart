part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostSelectSuccess extends PostState {
  final File selectedImage;

  PostSelectSuccess({
    @required this.selectedImage,
  });

  @override
  List<Object> get props => [];
}

class PostSelectCancle extends PostState {
  @override
  List<Object> get props => [];
}

class PostSelectFailure extends PostState {
  @override
  List<Object> get props => [];
}

class PostSubmitSuccess extends PostState {
  @override
  List<Object> get props => [];
}

class PostSubmitFailure extends PostState {
  @override
  List<Object> get props => [];
}

class PostSubmitInProgress extends PostState {
  @override
  List<Object> get props => [];
}
