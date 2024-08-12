part of 'assistant_cubit.dart';

class AssistantState extends Equatable {
  const AssistantState();

  @override
  List<Object> get props => [];
}

class AssistantInitial extends AssistantState {
  final List<ChatMessage> messages;

  const AssistantInitial(this.messages);
}

class AssistantLoading extends AssistantState {
  const AssistantLoading();
}

class AssistantMessageLoaded extends AssistantState {
  final List<ChatMessage> messages;

  const AssistantMessageLoaded(this.messages) : super();

  @override
  List<Object> get props => [messages];
}

class AssistantError extends AssistantState {
  final String error;

  const AssistantError(this.error);

  @override
  List<Object> get props => [error];
}
