part of 'addpost_bloc.dart';

abstract class AddpostEvent extends Equatable {
  const AddpostEvent();
}

class PostAddPressed extends AddpostEvent {
  @override
  String toString() => 'PostAddPressed';
  @override
  List<Object> get props => [];
}

class PostAddCancelled extends AddpostEvent {
  @override
  String toString() => 'PostAddCancelled';
  @override
  List<Object> get props => [];
}

class PostSubmitPressed extends AddpostEvent {
  final File image;

  final String caption;
  PostSubmitPressed({
    @required this.caption,
    @required this.image,
  });

  @override
  List<Object> get props => [image];
}
