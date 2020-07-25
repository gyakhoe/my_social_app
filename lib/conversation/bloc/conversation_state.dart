part of 'conversation_bloc.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();
}

class ConversationInitial extends ConversationState {
  @override
  List<Object> get props => [];
}

class ConversationLoadingInprogress extends ConversationState {
  @override
  List<Object> get props => [];
}

class ConversationLoadingSuccess extends ConversationState {
  final List<Conversation> conversations;
  ConversationLoadingSuccess(this.conversations);
  @override
  List<Object> get props => [];
}

class ConversationLoadingFailure extends ConversationState {
  final String failureMessage;
  ConversationLoadingFailure(this.failureMessage);
  @override
  List<Object> get props => [];
}
