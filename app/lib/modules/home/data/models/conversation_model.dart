import 'dart:convert';

import '../../domain/entities/conversation_entity.dart';


class ConversationModel extends ConversarionEntity {
  ConversationModel({
    required int id,
    required List<int> userIds,
   
  }) : super(
          id: id,
          userIds: userIds,
        );

  @override
  String toString() {
    return 'ConversationModel(id: $id, userIds: $userIds)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'userIds': userIds, 
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    print('... map $map');
    print('... map[id] ${map['id'].runtimeType }'  );
    print('... map[userIds] ${map['userIds'].runtimeType }'  );
    return ConversationModel(
      id: map['id'] ?? '',
      userIds: [...map['userIds'].map<dynamic>((userId) => userId as int).toList()], 
    );
  }
 

  static List<ConversationModel> fromJsonList(List<dynamic> json) {
    var list = <ConversationModel>[];

    if (json.isNotEmpty) {
      list = json.map((jsomItem) => ConversationModel.fromJson(jsomItem)).toList();
    }

    return list;
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) => ConversationModel.fromMap(json.decode(source));
}
