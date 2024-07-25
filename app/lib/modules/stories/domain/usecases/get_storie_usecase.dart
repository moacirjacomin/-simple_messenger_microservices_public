import 'package:dartz/dartz.dart';

import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../repositories/stories_repository.dart';
 

class GetStoriesUsecase extends UseCase<void, StoriesParams> {
  final StoriesRepository repository;

  GetStoriesUsecase({required this.repository});

  @override
  Future<Either<Failure, CurrentUser>> call(StoriesParams params) =>
      repository.example(params.email, params.password);
}

class StoriesParams {
  final String email;
  final String password;

  StoriesParams({
    required this.email,
    required this.password,
  });
}
