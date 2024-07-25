import 'package:dartz/dartz.dart';

import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../repositories/call_repository.dart';
 

class GetCallUsecase extends UseCase<void, CallParams> {
  final CallRepository repository;

  GetCallUsecase({required this.repository});

  @override
  Future<Either<Failure, CurrentUser>> call(CallParams params) =>
      repository.example(params.email, params.password);
}

class CallParams {
  final String email;
  final String password;

  CallParams({
    required this.email,
    required this.password,
  });
}
