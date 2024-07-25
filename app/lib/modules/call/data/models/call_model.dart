import 'dart:convert';

import '../../domain/entities/call_entity.dart';

class CallModel extends CallEntity {
  const CallModel({
    required String id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  @override
  String toString() {
    return 'CallModel(id: $id, name: $name)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'name': name,
    };
  }

  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  static List<CallModel> fromJsonList(List<dynamic> json) {
    var list = <CallModel>[];

    if (json.isNotEmpty) {
      list = json.map((jsomItem) => CallModel.fromJson(jsomItem)).toList();
    }

    return list;
  }

  String toJson() => json.encode(toMap());

  factory CallModel.fromJson(String source) => CallModel.fromMap(json.decode(source));
}
