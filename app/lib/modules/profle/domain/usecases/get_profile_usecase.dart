import 'package:dartz/dartz.dart';

import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../repositories/profile_repository.dart';
 

class GetProfileUsecase extends UseCase<void, ProfileParams> {
  final ProfileRepository repository;

  GetProfileUsecase({required this.repository});

  @override
  Future<Either<Failure, CurrentUser>> call(ProfileParams params) =>
      repository.example(params.email, params.password);
}

class ProfileParams {
  final String email;
  final String password;

  ProfileParams({
    required this.email,
    required this.password,
  });
}
