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
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/update_push_token_user_usecase.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUsecase signUpUsecase;
  final SharedNavigator sharedNavigator;
  final AuthNavigator navigator;
  final UpdatePushTokenUserUsecase updatePushTokenUserUsecase;
  final GetPushTokenUserUsecase getPushTokenUserUsecase;

  SignUpCubit({
    required this.sharedNavigator,
    required this.signUpUsecase,
    required this.navigator,
    required this.updatePushTokenUserUsecase,
    required this.getPushTokenUserUsecase,
  }) : super(const SignUpState());

  Future<void> onSignUpClicked({required String name, required String email, required String password, required String type}) async {
    emit(state.copyWith(status: Status.loading));
    final result = await signUpUsecase(SignUpParams(
      name: name,
      email: email,
      password: password,
      type: type,
    ));

    result.fold(
      (failure) {
        emit(state.copyWith(status: Status.failure, failure: failure));
      },
      (user) {
        print('... AUTH onSignUpClicked user=$user ');

        _saveUser(user);
        emit(state.copyWith(status: Status.success));
      },
    );
  }

  Future _saveUser(CurrentUser user) async {
    Modular.get<AppCubit>().updateCurrentUserUsecase(user);

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

  Future onSignInClicked() async {
    navigator.openSignInPage();
  }
}
