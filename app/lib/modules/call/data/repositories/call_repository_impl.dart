import 'package:dartz/dartz.dart';

import '../../../_shared/data/error_report/errors_report.dart';
 
import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../domain/repositories/call_repository.dart';
import '../datasources/call_local_datasource.dart';
import '../datasources/call_remote_datasource.dart';

class CallRepositoryImpl implements CallRepository {
  final CallRemoteDatasource exampleRemoteDatasource;
  final CallLocalDatasource exampleLocalDatasource;
  final ErrorsReport errorsReport;

  CallRepositoryImpl({
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
