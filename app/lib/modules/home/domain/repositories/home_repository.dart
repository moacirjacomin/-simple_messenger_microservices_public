import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../data/models/friend_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<FriendModel>>> getFriends(int currentUserId);
}
