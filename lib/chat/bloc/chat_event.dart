part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class ChatWithUserPressed extends ChatEvent {
  final User receiver;

  ChatWithUserPressed({
    this.receiver,
  });
  @override
  List<Object> get props => [];
}

class ChatWithIdPressed extends ChatEvent {
  final String chatId;
  ChatWithIdPressed(this.chatId);
  @override
  List<Object> get props => [];
}

class ChatMessageSent extends ChatEvent {
  final Chat chat;
  final String message;

  ChatMessageSent({
    this.chat,
    this.message,
  });

  @override
  String toString() => 'ChatMessageSent';
  @override
  List<Object> get props => [];
}

class ChatMessageReceived extends ChatEvent {
  @override
  String toString() => 'ChatMessageReceived';
  @override
  List<Object> get props => [];
}

class ChatPhotoSent extends ChatEvent {
  final File photo;

  ChatPhotoSent(this.photo);
  @override
  String toString() => 'ChatPhotoSent';
  @override
  List<Object> get props => [];
}

class ChatPhotoReceived extends ChatEvent {
  @override
  String toString() => 'ChatPhotoReceived';
  @override
  List<Object> get props => [];
}
