import '../../../_shared/constants/app_network.dart';
import '../../../_shared/data/network/logged_dio.dart';
import '../../../_shared/domain/entities/current_user.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDatasource {
  Future<CurrentUser> example(String email, String password);
  Future<List<ProfileModel>> getProfiles();
  Future<void> updateAllowNotification(bool allowFlag);
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  // final NotLoggedDio notLoggedDio;
  final LoggedDio loggedDio;
  final AppNetwork appNetwork;

  const ProfileRemoteDatasourceImpl({
    // required this.notLoggedDio,
    required this.loggedDio,
    required this.appNetwork,
  });

  @override
  Future<CurrentUser> example(String email, String password) async {
    print('... DATA SOURCE email=$email password=$password');

    // FAKE example
    // await Future.delayed(Duration(seconds: 3));
    // print('... signIn appNetwork=${appNetwork.signUp}');
    // String fakeData = '''
    //   {
    //     "id": "adadadsadasd",
    //     "name": "Roberto Logado",
    //     "email": "roberto@teste.com",
    //     "avatar":"https://xsgames.co/randomusers/avatar.php?g=male",
    //     "type": "customer"
    //   }
    //   ''';

    // final fakeJson = json.decode(fakeData);
    // return CurrentUser.fromJson(fakeData);

    // REAL request
    var result = await loggedDio.post(
      // appNetwork.signIn, // /auth
      '/some_route',
      data: {
        'email': email,
        'password': password,
        'admin': true,
      },
    );

    print('... DATA SOURCE result.data=${result.data}');

    return CurrentUser.fromMap(result.data);
  }

  @override
  Future<List<ProfileModel>> getProfiles() async {
    var result = await loggedDio.get(
        // appNetwork.signIn, // /auth
        '/some_route');

    return result.data.map<ProfileModel>((e) => ProfileModel.fromJson(e)).toList();
  }
  
  @override
  Future<void> updateAllowNotification(bool allowFlag) async {
    print('... PROFILE REMOTE DATASOURCE -updateAllowNotification allowFlag=${allowFlag} endPoint=${appNetwork.profileAllowNotif}');
    var result = await loggedDio.put(
      appNetwork.profileAllowNotif, // /profile/notification
      data: {
        'allow_notification': allowFlag
      },
    );

    print('... result=${result}');
  }
}
