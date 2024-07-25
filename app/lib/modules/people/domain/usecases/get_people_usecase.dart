import 'package:dartz/dartz.dart';

import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../repositories/people_repository.dart';
 

class GetPeopleUsecase extends UseCase<void, PeopleParams> {
  final PeopleRepository repository;

  GetPeopleUsecase({required this.repository});

  @override
  Future<Either<Failure, CurrentUser>> call(PeopleParams params) =>
      repository.example(params.email, params.password);
}

class PeopleParams {
  final String email;
  final String password;

  PeopleParams({
    required this.email,
    required this.password,
  });
}
