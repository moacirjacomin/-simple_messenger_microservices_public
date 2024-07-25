import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/presentation/cubit/app_cubit.dart';
import '../../../_shared/shared_navigator.dart';
import '../../auth_navigator.dart';
import '../../domain/usecases/get_push_token_user_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/update_push_token_user_usecase.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SharedNavigator sharedNavigator;
  final SignInUsecase signInUsecase;
  final AuthNavigator navigator;
  final UpdatePushTokenUserUsecase updatePushTokenUserUsecase;
  final GetPushTokenUserUsecase getPushTokenUserUsecase;

  SignInCubit({
    required this.sharedNavigator,
    required this.signInUsecase,
    required this.navigator,
    required this.updatePushTokenUserUsecase,
    required this.getPushTokenUserUsecase,
  }) : super(const SignInState());

  void onSignUpClicked() {
    navigator.openSignUpPage();
  }

  void onSignInClicked({required String email, String? password}) {
    print('onSignInClicked');

    _signIn(email, password!);
  }

  Future _signIn(String email, String password) async {
    emit(state.copyWith(status: Status.loading));
    final result = await signInUsecase(SignInParams(
      email: email,
      password: password,
    ));

    result.fold(
      (failure) {
        emit(state.copyWith(status: Status.failure, failure: failure));
      },
      (user) async {
        // check is devicePushToken need a update
        // var resultoToken = await getPushTokenUserUsecase(Void);
        // resultoToken.fold(
        //   (failure) {},
        //   (currentPushDeviceToken) async {
        //     if (currentPushDeviceToken != user.pushDeviceToken) {
        //       print('... AUTH CUBIR currentPushDeviceToken != user.pushDeviceToken');
        //       user.pushDeviceToken = currentPushDeviceToken;
        //     }

        //     await _saveUser(user, currentPushDeviceToken != user.pushDeviceToken);
        //     emit(state.copyWith(status: Status.success));
        //   },
        // );
        _saveUser(user);
        emit(state.copyWith(status: Status.success));
      },
    );
  }

  Future _saveUser(CurrentUser user) async {
    print('... SIGN_IN CUBIT user=${user}');
    Modular.get<AppCubit>().updateCurrentUserUsecase(user);

    // if(shouldUpdateToken){
    //   var resultUpdateRemotoPushDeviceToken = await updatePushTokenUserUsecase(user.pushDeviceToken);
    // }

        // check is devicePushToken need a update
    var resultoToken = await getPushTokenUserUsecase(Void);
    resultoToken.fold(
      (failure) {},
      (currentPushDeviceToken) async {
        if (currentPushDeviceToken != user.pushDeviceToken) {
          print('... AUTH CUBIR currentPushDeviceToken != user.pushDeviceToken');
          user.pushDeviceToken = currentPushDeviceToken;

          Modular.get<AppCubit>().updateCurrentUserUsecase(user.copyWith(pushDeviceToken: currentPushDeviceToken));

          var resultUpdateRemotoPushDeviceToken = await updatePushTokenUserUsecase(currentPushDeviceToken);
        }
      },
    );

    sharedNavigator.openHome();
  }
}
