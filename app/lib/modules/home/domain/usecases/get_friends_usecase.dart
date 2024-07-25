import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../../data/models/friend_model.dart';
import '../repositories/home_repository.dart';

class GetFriendsUsecase extends UseCase<void, int> {
  final HomeRepository repository;

  GetFriendsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<FriendModel>>> call(param) => repository.getFriends(param);
}
