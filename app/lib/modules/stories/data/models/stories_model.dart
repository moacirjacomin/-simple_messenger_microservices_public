import 'dart:convert';

import '../../domain/entities/stories_entity.dart';

class StoriesModel extends StoriesEntity {
  const StoriesModel({
    required String id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  @override
  String toString() {
    return 'StoriesModel(id: $id, name: $name)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'name': name,
    };
  }

  factory StoriesModel.fromMap(Map<String, dynamic> map) {
    return StoriesModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  static List<StoriesModel> fromJsonList(List<dynamic> json) {
    var list = <StoriesModel>[];

    if (json.isNotEmpty) {
      list = json.map((jsomItem) => StoriesModel.fromJson(jsomItem)).toList();
    }

    return list;
  }

  String toJson() => json.encode(toMap());

  factory StoriesModel.fromJson(String source) => StoriesModel.fromMap(json.decode(source));
}
