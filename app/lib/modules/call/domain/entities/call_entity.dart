import 'package:equatable/equatable.dart';

class CallEntity extends Equatable {
  final String id;
  final String name;

  const CallEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
