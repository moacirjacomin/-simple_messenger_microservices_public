import 'package:dartz/dartz.dart';

import '../../../_shared/data/error_report/errors_report.dart';
 
import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../domain/repositories/stories_repository.dart';
import '../datasources/stories_local_datasource.dart';
import '../datasources/stories_remote_datasource.dart';

class StoriesRepositoryImpl implements StoriesRepository {
  final StoriesRemoteDatasource exampleRemoteDatasource;
  final StoriesLocalDatasource exampleLocalDatasource;
  final ErrorsReport errorsReport;

  StoriesRepositoryImpl({
    required this.exampleRemoteDatasource,
    required this.exampleLocalDatasource,
    required this.errorsReport,
    // required this.dio,
  });

  @override
  Future<Either<Failure, CurrentUser>> example(String email, String password) async {
    try {
      final result = await exampleRemoteDatasource.example(email, password);

      exampleLocalDatasource.updateCurrentUser(result);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }
 
}
