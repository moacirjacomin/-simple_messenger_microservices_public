import 'package:equatable/equatable.dart';

class PeopleEntity extends Equatable {
  final String id;
  final String name;

  PeopleEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
