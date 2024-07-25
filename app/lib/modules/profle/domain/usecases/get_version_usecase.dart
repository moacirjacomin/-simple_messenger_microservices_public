import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../repositories/profile_repository.dart';

class GetVersionUsecase extends UseCase<String, NoParams> {
  final ProfileRepository repository;

  GetVersionUsecase({required this.repository});

  @override
  Future<Either<Failure, String>> call(NoParams params) => repository.getVersion();
}
