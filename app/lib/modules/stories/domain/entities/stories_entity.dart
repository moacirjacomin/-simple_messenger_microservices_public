import 'package:equatable/equatable.dart';

class StoriesEntity extends Equatable {
  final String id;
  final String name;

  const StoriesEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
