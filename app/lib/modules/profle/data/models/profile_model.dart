import 'dart:convert';

import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required String id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  @override
  String toString() {
    return 'ProfileModel(id: $id, name: $name)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'name': name,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  static List<ProfileModel> fromJsonList(List<dynamic> json) {
    var list = <ProfileModel>[];

    if (json.isNotEmpty) {
      list = json.map((jsomItem) => ProfileModel.fromJson(jsomItem)).toList();
    }

    return list;
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) => ProfileModel.fromMap(json.decode(source));
}
