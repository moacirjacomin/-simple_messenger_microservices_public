import 'dart:convert';

class CurrentUser {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final String type;
  String token;
  String pushDeviceToken;
  bool? allowNotification;

  CurrentUser({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.type,
    this.token = '',
    this.pushDeviceToken = '',
    this.allowNotification = true,
  });

  @override
  String toString() {
    return 'CurrentUser(id: $id, name: $name, email: $email, notif: $allowNotification,  pushDeviceToken=$pushDeviceToken, token: $token, avatar: $avatar)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'type': type,
      'token': token,
      'allow_notification': allowNotification,
      'pushDeviceToken': pushDeviceToken,
    };
  }

  factory CurrentUser.fromMap(Map<String, dynamic> map, [String? token]) {
    return CurrentUser(
      id: map['id'].toString(),
      name: map['name'] ?? (map['firstName'] != null ? (map['firstName'] + ' ' + map['lastName']) : ''),
      email: map['email'] ?? '',
      // avatar: map['avatar'] ?? 'https://eu.ui-avatars.com/api/?name=${map['firstName']}&background=random&rounded=true',
      avatar: map['avatar'] ?? 'https://randomuser.me/api/portraits/men/${map['id']}.jpg',
      type: map['type'] ?? 'user',
      token: map['token'] ?? token ?? '',
      pushDeviceToken: map['pushDeviceToken'] ?? '',
      allowNotification: map['allow_notification'] ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentUser.fromJson(String source) => CurrentUser.fromMap(json.decode(source));

  CurrentUser copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    String? type,
    String? token,
    String? pushDeviceToken,
    bool? allowNotification,
  }) {
    return CurrentUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      type: type ?? this.type,
      token: token ?? this.token,
      pushDeviceToken: pushDeviceToken ?? this.pushDeviceToken,
      allowNotification: allowNotification ?? this.allowNotification,
    );
  }
}
