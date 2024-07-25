import 'package:dartz/dartz.dart';

import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../repositories/example_repository.dart';
 

class GetExampleUsecase extends UseCase<void, ExampleParams> {
  final ExampleRepository repository;

  GetExampleUsecase({required this.repository});

  @override
  Future<Either<Failure, CurrentUser>> call(ExampleParams params) =>
      repository.example(params.email, params.password);
}

class ExampleParams {
  final String email;
  final String password;

  ExampleParams({
    required this.email,
    required this.password,
  });
}
