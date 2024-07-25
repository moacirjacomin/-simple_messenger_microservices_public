import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/shared_actions.dart';

part 'user_edit_state.dart';

class UserEditCubit extends Cubit<UserEditState> {
  final SharedActions sharedActions;

  late CurrentUser? initialUserData;
  UserEditCubit(
    this.sharedActions,
  ) : super(UserEditState());

  onInit(CurrentUser? currentUser) {
    if (currentUser != null) {
      initialUserData = currentUser;
      // emit(state.copyWith(name: currentUser.name, picture: currentUser.avatar, email: currentUser.email));
    }
  }

  onSave({required String name, required String email, required BuildContext context}) async {
    print('SAVE ocorreu: $name  $email');

    // step 1. if nothing change, only returns
    if (initialUserData?.name == name && initialUserData?.email == email) {
      Navigator.of(context).pop(null);
      return;
    }

    // step 2. update current user locally
    emit(state.copyWith(status: Status.loading));
    var newUserData = initialUserData!.copyWith(name: name, email: email, avatar: 'https://xsgames.co/randomusers/avatar.php?g=male');
    sharedActions.updateCurrentUser(newUserData);

    // step 3. update user remotelly
    await Future.delayed(Duration(seconds: 3));
    emit(state.copyWith(status: Status.success));
    // TODO: create a endpoint to this

    Navigator.of(context).pop(newUserData);
  }

  Future<void> onImageSourceSelected(String source) async {}
}
