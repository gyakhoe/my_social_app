part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();
}

class MessageTextSent extends MessageEvent {
  final Chat chatDetail;
  final String messageText;

  MessageTextSent({
    @required this.chatDetail,
    @required this.messageText,
  });

  @override
  String toString() => 'MessageTextSent';

  @override
  List<Object> get props => [];
}

class MessageLoadRequested extends MessageEvent {
  final String chatId;
  MessageLoadRequested(this.chatId);
  @override
  String toString() => 'MessageLoadRequested';
  @override
  List<Object> get props => [];
}

class MessageLoaded extends MessageEvent {
  final List<Message> messages;
  MessageLoaded(this.messages);
  @override
  String toString() => 'MessagesLoaded';
  @override
  List<Object> get props => [];
}
