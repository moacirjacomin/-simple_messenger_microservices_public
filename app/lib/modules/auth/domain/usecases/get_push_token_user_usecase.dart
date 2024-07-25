import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../repositories/auth_repository.dart';

class GetPushTokenUserUsecase extends UseCase<String, void> {
  final AuthRepository repository;

  GetPushTokenUserUsecase({required this.repository});

  @override
  Future<Either<Failure, String>> call(void param) => repository.getPushTokenUser();
}
