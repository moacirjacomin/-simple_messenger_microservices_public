import '../../../_shared/constants/app_network.dart';
import '../../../_shared/data/network/logged_dio.dart';
import '../models/friend_model.dart';

abstract class HomeRemoteDatasource {
  Future<List<FriendModel>> getFriends(int currentUserId);
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final LoggedDio loggedDio;
  final AppNetwork appNetwork;

  const HomeRemoteDatasourceImpl({
    required this.loggedDio,
    required this.appNetwork,
  });

  @override
  Future<List<FriendModel>> getFriends(int currentUserId) async {
    var result = await loggedDio.get(appNetwork.getFriends); // /get-friends

    return result.data.map<FriendModel>((e) => e['creator']['id'] == currentUserId ? FriendModel.fromMap(e['receiver']) : FriendModel.fromMap(e['creator'])
    // {
    //   if (e['creator']['id'] == currentUserId) {
    //     return FriendModel.fromMap(e['receiver']);
    //   } else {
    //     return FriendModel.fromMap(e['creator']);
    //   }
    // }
    ).toList() as List<FriendModel>;

    
  }
}
