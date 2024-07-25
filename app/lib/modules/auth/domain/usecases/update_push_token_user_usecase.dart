import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../repositories/auth_repository.dart';

class UpdatePushTokenUserUsecase extends UseCase<void, String> {
  final AuthRepository repository;

  UpdatePushTokenUserUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(String param) => repository.updatePushTokenUser(param);
}
