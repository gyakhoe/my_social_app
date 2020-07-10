part of 'addpost_bloc.dart';

abstract class AddpostState extends Equatable {
  const AddpostState();
}

class AddpostInitial extends AddpostState {
  @override
  List<Object> get props => [];
}

class PostSelectSuccess extends AddpostState {
  final File selectedImage;

  PostSelectSuccess({
    @required this.selectedImage,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => 'PostSelectSuccess';
}

class PostSelectCancel extends AddpostState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'PostSubmitCancle';
}

class PostSelectFailure extends AddpostState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'PostSubmitFailure';
}

class PostSubmitSuccess extends AddpostState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'PostSubmitSuccess';
}

class PostSubmitFailure extends AddpostState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'PostSubmitFailure';
}

class PostSubmitInProgress extends AddpostState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'PostSubmitInProgress';
}
