part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatUserLoading extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatUserSuccess extends ChatState {
  final User currentUser;
  final Chat chat;

  ChatUserSuccess({
    @required this.chat,
    @required this.currentUser,
  });

  @override
  List<Object> get props => [];
}

class ChatUserFailure extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatMessageSuccess extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatMessageFailure extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatMessageLoading extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatPhotoSuccess extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatPhotoFailure extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatPhotoLoading extends ChatState {
  @override
  List<Object> get props => [];
}
