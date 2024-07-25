import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../_shared/constants/app_network.dart';
import '../../../_shared/data/network/logged_dio.dart';
import '../../../_shared/data/network/not_logged_dio.dart';
import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';

abstract class AuthRemoteDatasource {
  Future<CurrentUser> signIn(String email, String password);
  Future<CurrentUser> signUp(String name, String email, String password, String type);
  Future<void> updatePushTokenUser(String pushToken);
  Future<String> getPushTokenUser();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final NotLoggedDio notLoggedDio;
  final LoggedDio loggedDio;
  final AppNetwork appNetwork;

  const AuthRemoteDatasourceImpl({
    required this.notLoggedDio,
    required this.loggedDio,
    required this.appNetwork,
  });


 @override
  Future<void> updatePushTokenUser(String pushToken) async {
    print('... AUTH REMOTE DATASOURCE -updatePushTokenUser  pushToken=$pushToken endPoint=${appNetwork.updatePushTokenNotif}');
    await loggedDio.put(
      appNetwork.updatePushTokenNotif, // profile/push-token
      data: {
        'pushDeviceToken': pushToken
      },
    );
  }

  @override
  Future<CurrentUser> signIn(String email, String password) async {
    print('... AUTH DATASOURCE appNetwork.signIn=${appNetwork.signIn}');
    var result = await notLoggedDio.post(
      appNetwork.signIn, //  /auth/login
      data: {
        'email': email,
        'password': password,
      },
    );

    return CurrentUser.fromMap(result.data['user'], result.data['token']);
  }

  @override
  Future<CurrentUser> signUp(String name, String email, String password, String type) async {
    print('... signUp appNetwork=${appNetwork.signUp}');
    final pushDeviceToken = await FirebaseMessaging.instance.getToken();
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
    // return CurrentUser.fromJson(fakeJson);

    var result = await notLoggedDio.post(
      appNetwork.signUp, // /auth/register
      data: {
        'email': email,
        'password': password,
        'firstName': name.split(' ')[0],
        'lastName':  name.split(' ')[1],
        'pushDeviceToken': pushDeviceToken
      },
    );

    if(result.statusCode == 201 || result.statusCode == 200){
      return await signIn( email,  password);
    }

    throw Failure(exception: Exception('Some went veeery wrong')); 
  }
  
  @override
  Future<String> getPushTokenUser() async {
    final pushDeviceToken = await FirebaseMessaging.instance.getToken() ?? '';
    return pushDeviceToken;
  }
}
