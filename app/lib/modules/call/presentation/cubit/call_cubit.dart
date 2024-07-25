import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/shared_navigator.dart';
import '../../domain/usecases/get_call_usecase.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  final GetCallUsecase exampleUsecase;
  final SharedNavigator sharedNavigator;
  CallCubit(
    this.exampleUsecase,
    this.sharedNavigator,
  ) : super(CallState());

  Future exampleCubitCall(String email, String password) async {
    emit(state.copyWith(status: Status.loading));
    final result = await exampleUsecase(CallParams(
      email: email,
      password: password,
    ));

    result.fold(
      (failure) {
        emit(state.copyWith(status: Status.failure, failure: failure, errorMessage: failure.getMessage() ));
      },
      (user) {
        
        emit(state.copyWith(status: Status.success));
      },
    );
  }
}
