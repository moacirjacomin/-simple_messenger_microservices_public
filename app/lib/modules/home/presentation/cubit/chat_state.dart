part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final Status? status;
  final List<MessageModel> messages;
  final String message;
  
  const ChatState({
    this.status = Status.initial,
    this.messages = const [],
    this.message = "",
  });

  @override
  List<Object?> get props => [
        status,
        messages,
        message,
      ];

  ChatState copyWith({
    Status? status,
    List<MessageModel>? messages,
    String? message,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      message: message ?? this.message,
    );
  }
}
 
