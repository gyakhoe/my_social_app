part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();
}

class ConverstationListRequested extends ConversationEvent {
  @override
  String toString() => 'ConversationListRequested';
  @override
  List<Object> get props => [];
}
