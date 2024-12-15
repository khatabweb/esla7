part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatSendSuccess extends ChatState {}

final class ChatStartSuccess extends ChatState {
  final int chatId;
  const ChatStartSuccess({required this.chatId});
}

final class ChatSuccess extends ChatState {
  final ChatModel chatModel;
  const ChatSuccess({required this.chatModel});
}

final class ChatError extends ChatState {
  final String error;
  const ChatError({required this.error});
}
