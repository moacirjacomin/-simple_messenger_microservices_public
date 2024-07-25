

import 'package:flutter_modular/flutter_modular.dart';

import 'domain/entities/current_user.dart';
import 'presentation/cubit/app_cubit.dart';

abstract class SharedActions {
  void updateAppointmentsOnHome();
  void updateEstimatesOnHome();
  Future<CurrentUser?> getCurrentUser();
  Future<void> updateCurrentUser(CurrentUser newValue);
  void logout();
}

class SharedActionsImpl implements SharedActions {
  @override
  Future<CurrentUser?> getCurrentUser() async{
    return await Modular.get<AppCubit>().getCurrentUser();
  }

  @override
  Future<void> updateCurrentUser(CurrentUser newValue) async{
    return Modular.get<AppCubit>().updateCurrentUser(newValue);
  }

  @override
  void updateAppointmentsOnHome() {
    // print('... SHARED ACTION - updateAppointmentsOnHome runs');
    // Modular.get<HomeCubit>().onRefresh();
  }
  
  @override
  void updateEstimatesOnHome() {
    // print('... SHARED ACTION - updateEstimatesOnHome runs');
    // Modular.get<HomeCubit>().refreshEstimate();
  }

  @override
  void logout() {
    print('... SHARED ACTION - logout runs');
    Modular.get<AppCubit>().logout();
  }
}
