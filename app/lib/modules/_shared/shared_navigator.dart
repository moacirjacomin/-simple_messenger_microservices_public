import 'package:flutter_modular/flutter_modular.dart';

import '../auth/auth_module.dart';
import '../home/data/models/friend_model.dart';
import 'domain/entities/current_user.dart';
 

class SharedNavigator {
  SharedNavigator();
  //   SharedNavigator._();
  // static final SharedNavigator _instance = SharedNavigator._();

  // static SharedNavigator setup() {
  //   return _instance;
  // }

  void openLogin() {
    return Modular.to.navigate(AuthModule.moduleName);
  }

  void openChat(FriendModel friend){
    // Modular.to.navigate('/home/chat/room', arguments: friend);
    Modular.to.pushNamed('/home/chat/room', arguments: friend);
  }

  void openHome() {
    // Modular.to.navigate(HomeModule.moduleName);
    // Modular.to.navigate('/home/chat');
    Modular.to.navigate('/home/chat/');
  }

  Future<dynamic> openUserEdit(CurrentUser currentUser) async {
    return Modular.to.pushNamed('/home/profile/user_edit', arguments: currentUser);
  }

  void back() {
    Modular.to.pop();
  }

  // void openOrderRequestModal(OrderRequest order) {
  //   Modular.to.pushNamed(
  //     OrderRequestModule.moduleName,
  //     arguments: order,
  //   );
  // }
 
  
}
