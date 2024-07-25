import 'package:dartz/dartz.dart';

import '../../../_shared/data/error_report/errors_report.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/friend_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource homeRemoteDatasource;
  final HomeLocalDatasource homeLocalDatasource;
  final ErrorsReport errorsReport;

  HomeRepositoryImpl({
    required this.homeRemoteDatasource,
    required this.homeLocalDatasource,
    required this.errorsReport,
  });


  @override
  Future<Either<Failure, List<FriendModel>>> getFriends(int currentUserId) async {
    try {
      final result = await homeRemoteDatasource.getFriends(currentUserId);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }
}
