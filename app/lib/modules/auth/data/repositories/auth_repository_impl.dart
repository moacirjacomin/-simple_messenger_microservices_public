import 'dart:ffi';

import 'package:dartz/dartz.dart';

import '../../../_shared/constants/app_network.dart';
import '../../../_shared/data/error_report/errors_report.dart';
import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AppNetwork appNetwork;
  final ErrorsReport errorsReport;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.appNetwork,
    required this.errorsReport,
  });

  @override
  Future<Either<Failure, CurrentUser>> signIn(String email, String password) async {
    try {
      final result = await authRemoteDatasource.signIn(email, password);
      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, CurrentUser>> signUp(String name, String email, String password, String type) async {
    try {
      final result = await authRemoteDatasource.signUp(name, email, password, type);
      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, void>> updatePushTokenUser(String pushToken) async {
    try {
      await authRemoteDatasource.updatePushTokenUser(pushToken);
      return Right(Void);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, String>> getPushTokenUser() async {
    try {
      var resultToken = await authRemoteDatasource.getPushTokenUser();
      return Right(resultToken);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }
}
