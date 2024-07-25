import '../../domain/entities/current_user.dart';
import '../storage/local_storage_secure.dart';

abstract class CoreLocalDataSource {
  bool isDarkMode([bool? defaultValue]);

  void toggleDarkMode();

  Future<CurrentUser?> currentUser();

  void updateCurrentUser(CurrentUser currentUser);

  void logout();
}

class CoreLocalDataSourceImpl implements CoreLocalDataSource {
  final LocalStorage localStorage;
  CoreLocalDataSourceImpl(
    this.localStorage,
  ){
    // localStorage.init(); // TODO: verificar se isso ainda eh necessario
  }

  @override
  bool isDarkMode([bool? defaultValue]) {
    print('... DATASOURCE CORE -isDarkMode- defaultValue=$defaultValue ');
    return localStorage.getBool('isDarkMode') ?? (defaultValue ?? false);
  }

  @override
  void toggleDarkMode() {
    bool currentValue = isDarkMode();
    localStorage.setBool('isDarkMode', !currentValue);
  }

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
  }

  @override
  void logout() async {
    // localStorage.clear();
    localStorage.remove('currentUser');
  }
  
 
}
