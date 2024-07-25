import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/data/datasources/core_local_datasource.dart';
import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/presentation/cubit/app_cubit.dart';
import '../../../_shared/shared_actions.dart';
import '../../../_shared/shared_navigator.dart';
import '../../data/models/friend_model.dart';
import '../../domain/usecases/get_friends_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final SharedNavigator sharedNavigator;
  final SharedActions sharedActions;
  final GetFriendsUsecase getFriendsUsecase;
  late CurrentUser? _currentUser;

  HomeCubit({
    required this.sharedNavigator,
    required this.sharedActions,
    required this.getFriendsUsecase,
  }) : super(const HomeState());

  onInit() async {
    print('... HOME CUBIT - onInit');
    _currentUser = await Modular.get<CoreLocalDataSource>().currentUser();

    if (_currentUser != null) {
      _loadFriends(int.parse(_currentUser!.id));
    }
  }

  Future<void> testAppCubit() async {
    // print('appCubit test ${appCubit.state.isDarkMode}');

    // Modular.get<LocalStorage>().clear();

    // ruining token to test interceptor

    CurrentUser? tempCurreUser = await Modular.get<CoreLocalDataSource>().currentUser();

    Modular.get<CoreLocalDataSource>().updateCurrentUser(tempCurreUser!.copyWith(token: ''));
    // Modular.get<CoreLocalDataSource>().logout();
  }

  toggleDarkMode() {
    Modular.get<AppCubit>().toggleDarkMode();
  }

  _loadFriends(int currentUserId) async {
    print('... HOME CUBIT - _loadFriends currentUserId=$currentUserId ');
    emit(state.copyWith(status: Status.loading));

    var getResult = await getFriendsUsecase(currentUserId);

    print('... HOME CUBIT getResult=$getResult');
    getResult.fold(
        (failture) => emit(
              state.copyWith(status: Status.failure, message: 'Error to load friends'),
            ), (friendsList) {
      print('... HOME CUBIT friendsList=${friendsList}');
      emit(state.copyWith(status: Status.success, friends: friendsList));
    });
  }

  logout() {
    sharedActions.logout();
  }

  onTapOpenChat(FriendModel friend) {
    sharedNavigator.openChat(friend);
  }
}
