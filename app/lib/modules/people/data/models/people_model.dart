import 'dart:convert';

import '../../domain/entities/people_entity.dart';

class PeopleModel extends PeopleEntity {
  PeopleModel({
    required String id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  @override
  String toString() {
    return 'PeopleModel(id: $id, name: $name)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'name': name,
    };
  }

  factory PeopleModel.fromMap(Map<String, dynamic> map) {
    return PeopleModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  static List<PeopleModel> fromJsonList(List<dynamic> json) {
    var list = <PeopleModel>[];

    if (json.isNotEmpty) {
      list = json.map((jsomItem) => PeopleModel.fromJson(jsomItem)).toList();
    }

    return list;
  }

  String toJson() => json.encode(toMap());

  factory PeopleModel.fromJson(String source) => PeopleModel.fromMap(json.decode(source));
}
