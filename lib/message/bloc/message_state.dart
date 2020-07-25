part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();
}

class MessageInitial extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageSendingSuccess extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageSendingInprogress extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageSendingFailure extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageLoadingInProgress extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageLoadingFailure extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageLoadingSuccess extends MessageState {
  final List<Message> messages;

  MessageLoadingSuccess(this.messages);
  @override
  List<Object> get props => [];
}
