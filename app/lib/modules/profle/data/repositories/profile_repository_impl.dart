import 'dart:ffi';

import 'package:dartz/dartz.dart';

import '../../../_shared/data/error_report/errors_report.dart';
import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource profileRemoteDatasource;
  final ProfileLocalDatasource profileLocalDatasource;
  final ErrorsReport errorsReport;

  ProfileRepositoryImpl({
    required this.profileRemoteDatasource,
    required this.profileLocalDatasource,
    required this.errorsReport,
    // required this.dio,
  });

  @override
  Future<Either<Failure, CurrentUser>> example(String email, String password) async {
    try {
      final result = await profileRemoteDatasource.example(email, password);

      profileLocalDatasource.updateCurrentUser(result);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, String>> getVersion() async {
    try {
      final result = await profileLocalDatasource.getVersion();

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }
  
  @override
  Future<Either<Failure, void>> updateAllowNotification(bool allowFlag) async {
  try {
    print('... PROFILE REPOSITORY - updateAllowNotification allowFlag=$allowFlag ');
      await profileRemoteDatasource.updateAllowNotification(allowFlag);

      return Right(Void);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }
}
