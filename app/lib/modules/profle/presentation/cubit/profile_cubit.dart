import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../../../_shared/shared_actions.dart';
import '../../../_shared/shared_navigator.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/get_version_usecase.dart';
import '../../domain/usecases/update_allow_notification_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUsecase exampleUsecase;
  final SharedNavigator sharedNavigator;
  final SharedActions sharedActions;
  final GetVersionUsecase getVersionUsecase;
  final UpdateAllowNotificationUsecase updateAllowNotificationUsecase;

  late CurrentUser _currentUser;
  ProfileCubit(
    this.exampleUsecase,
    this.sharedNavigator,
    this.sharedActions,
    this.getVersionUsecase,
    this.updateAllowNotificationUsecase,
  ) : super(ProfileState());

  void onInit() async {
    print('... PROFILE CUBIT - onInit');
    await _loadCurrentUser();
    await _loadAppVersion();
    // _loadProfileInformation();
  }

  Future<void> _loadCurrentUser() async {
    emit(state.copyWith(status: Status.loading));

    // await Future.delayed(Duration(seconds: 3));
    await Future.delayed(Duration.zero);
    var currentUser = await sharedActions.getCurrentUser();
    print('... PROFILE CUBIT -_loadCurrentUser- current user: $currentUser');

    if (currentUser == null) sharedNavigator.openLogin();

    _currentUser = currentUser!;
    emit(state.copyWith(
      status: Status.success,
      name: currentUser.name,
      picture: currentUser.avatar,
      allowNotification: currentUser.allowNotification ?? true,
    ));
  }

  Future<void> _loadAppVersion() async {
    final result = await getVersionUsecase(NoParams());
    result.fold(
      (failure) {
        // print('to caindo aqui');
        // // emit(state.copyWith(buttonStatus: Status.failure, failure: failure, allowNotification: !newValue));
        // emit(state.copyWith( allowNotification: !newValue));
      },
      (appVersion) {
        emit(state.copyWith(appVersion: appVersion));
      },
    );
  }

  void onPressLogout(){
    sharedActions.logout();
  }

  void onUpdateAllowNotification(bool newValue) async {
    // ideia: not a loading response for this one. Screen feedback then API call
    emit(state.copyWith(allowNotification: newValue));

    // change locally
    sharedActions.updateCurrentUser(_currentUser.copyWith(allowNotification: newValue));

    // change remotelly  // 
    final result = await updateAllowNotificationUsecase(newValue);
    result.fold(
      (failure) {
        emit(state.copyWith( allowNotification: !newValue, status: Status.failure, failure: failure, errorMessage: 'Ops, um erro ocorreu. Tente novamente mais tarde' ));
      },
      (singleResponse) {
        // updateAuthUserUsecase(_currentUser!.copyWith(allowNotification: newValue));
        print('... tudo OK ');
      },
    );
  }

  logout() {
    sharedActions.logout();
  }

  Future exampleCubitCall(String email, String password) async {
    emit(state.copyWith(status: Status.loading));
    final result = await exampleUsecase(ProfileParams(
      email: email,
      password: password,
    ));

    result.fold(
      (failure) {
        emit(state.copyWith(status: Status.failure, failure: failure, errorMessage: failure.getMessage()));
      },
      (user) {
        emit(state.copyWith(status: Status.success));
      },
    );
  }

  void updateUserData(CurrentUser newUserData){
    _currentUser = newUserData;

    emit(state.copyWith(name: newUserData.name, picture: newUserData.avatar));

  }

  Future<dynamic> onPressEdit() async {
    
    return sharedNavigator.openUserEdit(_currentUser);
  }

}
