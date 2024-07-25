
class AppNetwork {
  AppNetwork( );

  String get baseUrl => const String.fromEnvironment('BASE_URL');

  String get signUp => '$baseUrl/auth/register';

  String get signIn => '$baseUrl/auth/login';

  String get profileAllowNotif => '$baseUrl/profile/notification';

  String get updatePushTokenNotif => '$baseUrl/profile/push-token';

  String get forgotPassword => '$baseUrl/login/forgotPass';

  String get signOut => '$baseUrl/login/signout';

  String get newPassword => '$baseUrl/account/updatePassword';

  String get getFriends => '$baseUrl/get-friends';
}
