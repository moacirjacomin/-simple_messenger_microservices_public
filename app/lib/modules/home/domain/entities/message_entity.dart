import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final int id;
  final String message;
  final int creatorId;
  final int conversationId;

  MessageEntity({
    required this.id,
    required this.message,
    required this.creatorId,
    required this.conversationId,
  });

  @override
  List<Object> get props => [id, message, creatorId, conversationId];
}
