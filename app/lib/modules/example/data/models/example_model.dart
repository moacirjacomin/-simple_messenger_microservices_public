import 'dart:convert';

import '../../domain/entities/example_entity.dart';

class ExampleModel extends ExampleEntity {
  ExampleModel({
    required String id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  @override
  String toString() {
    return 'ExampleModel(id: $id, name: $name)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'name': name,
    };
  }

  factory ExampleModel.fromMap(Map<String, dynamic> map) {
    return ExampleModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  static List<ExampleModel> fromJsonList(List<dynamic> json) {
    var list = <ExampleModel>[];

    if (json.isNotEmpty) {
      list = json.map((jsomItem) => ExampleModel.fromJson(jsomItem)).toList();
    }

    return list;
  }

  String toJson() => json.encode(toMap());

  factory ExampleModel.fromJson(String source) => ExampleModel.fromMap(json.decode(source));
}
