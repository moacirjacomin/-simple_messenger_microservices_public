import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String name;

  const ProfileEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
