import 'dart:convert';

import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required int id,
    required String message,
    required int creatorId,
    required int conversationId,
  }) : super(
          id: id,
          message: message,
          creatorId: creatorId,
          conversationId: conversationId,
        );

  @override
  String toString() {
    return 'MessageModel(id: $id, conversationId: $conversationId, creatorId: $creatorId)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'message': message,
      'creatorId': creatorId,
      'conversationId': conversationId,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? 0,
      message: map['message'] ?? '',
      creatorId: map['creatorId'] ?? 0,
      conversationId: map['conversationId'] ?? 0,
    );
  }

  static List<MessageModel> fromJsonList(List<dynamic> json) {
    var list = <MessageModel>[];

    if (json.isNotEmpty) {
      list = json.map((jsomItem) => MessageModel.fromJson(jsomItem)).toList();
    }

    return list;
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));
}
