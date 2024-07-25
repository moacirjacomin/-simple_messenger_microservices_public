import 'package:equatable/equatable.dart';

class ConversarionEntity extends Equatable {
  final int id;
  final List<int> userIds; 

  ConversarionEntity({
    required this.id,
    required this.userIds,
  });

  @override
  List<Object> get props => [id, userIds];
}
