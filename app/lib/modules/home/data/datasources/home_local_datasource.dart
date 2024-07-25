import '../../../_shared/data/storage/local_storage_secure.dart';
import '../../../_shared/domain/entities/current_user.dart';

abstract class HomeLocalDatasource {
  Future<CurrentUser?> currentUser();

  void updateCurrentUser(CurrentUser currentUser);
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  // final NotLoggedDio notLoggedDio;
  final LocalStorage localStorage;

  const HomeLocalDatasourceImpl({
    required this.localStorage,
  });

  @override
  Future<CurrentUser?> currentUser() async {
    final currentUserJson = localStorage.getString('currentUser');

    if (currentUserJson == null) return null;

    final currentUser = CurrentUser.fromJson(currentUserJson);
    return currentUser;
  }

  @override
  Future<void> updateCurrentUser(CurrentUser currentUser) async {
    await localStorage.setString('currentUser', currentUser.toJson());
    await localStorage.setString('access_token', currentUser.token);
  }
}
