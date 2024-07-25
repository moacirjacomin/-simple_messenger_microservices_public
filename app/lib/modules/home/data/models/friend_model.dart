import 'dart:convert';

import '../../domain/entities/friend_entity.dart';

class FriendModel extends FriendEntity {
  FriendModel({
    required int id,
    required String name,
    required String firstName,
    required String lastName,
    required String email,
    required String avatar,
    required bool allowNotification,
  }) : super(
          id: id,
          name: name,
          firstName: firstName,
          lastName: lastName,
          email: email,
          avatar: avatar,
          allowNotification: allowNotification,
        );

  @override
  String toString() {
    return 'FriendModel(id: $id, name: $name)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'name': name,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'avatar': avatar,
      'allow_notification': allowNotification,
    };
  }

  factory FriendModel.fromMap(Map<String, dynamic> map) {
    return FriendModel(
      id: map['id'] ?? '',
      name: (map['firstName'] + ' ' + map['lastName']) ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      // avatar: map['avatar'] ?? 'https://eu.ui-avatars.com/api/?name=${map['firstName']}&background=random&rounded=true',
      avatar: map['avatar'] ?? 'https://randomuser.me/api/portraits/men/${map['id']}.jpg',
      allowNotification: map['allow_notification'] ?? false,
    );
  }

  /*
      {
        "id": 2,
        "creator": {
            "id": 1,
            "firstName": "Roberto",
            "lastName": "Teste",
            "email": "roberto@teste.com",
            "allow_notification": false
        },
        "receiver": {
            "id": 3,
            "firstName": "Maria",
            "lastName": "Testadora",
            "email": "maria@teste.com",
            "allow_notification": true
        }
    },
  */
  static List<FriendModel> fromFriendRequestJsonList(List<dynamic> json, int currentUserId) {
    var list = <FriendModel>[];

    if (json.isNotEmpty) {
      list = json.map((jsomItem) {
        if (jsomItem['creator']['id'] == currentUserId) {
          return FriendModel.fromJson(jsomItem['receiver']);
        } else {
          return FriendModel.fromJson(jsomItem['creator']);
        }
      }).toList();
    }

    return list;
  }

  static List<FriendModel> fromJsonList(List<dynamic> json) {
    var list = <FriendModel>[];

    if (json.isNotEmpty) {
      list = json.map((jsomItem) => FriendModel.fromJson(jsomItem)).toList();
    }

    return list;
  }

  String toJson() => json.encode(toMap());

  factory FriendModel.fromJson(String source) => FriendModel.fromMap(json.decode(source));
}
