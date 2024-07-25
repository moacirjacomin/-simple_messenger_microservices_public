import 'package:package_info_plus/package_info_plus.dart';

import '../../../_shared/data/storage/local_storage_secure.dart';
import '../../../_shared/domain/entities/current_user.dart';

abstract class ProfileLocalDatasource {
  Future<CurrentUser?> currentUser();

  void updateCurrentUser(CurrentUser currentUser);

  Future<String> getVersion();
}

class ProfileLocalDatasourceImpl implements ProfileLocalDatasource {
  // final NotLoggedDio notLoggedDio;
  final LocalStorage localStorage;

  const ProfileLocalDatasourceImpl({
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
    await localStorage.setString('access_token', currentUser.token!);
  }

  @override
  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    return '$version-$buildNumber';
  }
}
