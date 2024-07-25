import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../repositories/profile_repository.dart';

class UpdateAllowNotificationUsecase extends UseCase<void, bool> {
  final ProfileRepository repository;

  UpdateAllowNotificationUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(param) => repository.updateAllowNotification(param);
}
