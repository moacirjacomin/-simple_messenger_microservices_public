import 'package:equatable/equatable.dart';

class FriendEntity extends Equatable {
  final int id;
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;
  final bool allowNotification;

  FriendEntity({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
    required this.allowNotification,
  });

  @override
  List<Object> get props => [id, name];
}
