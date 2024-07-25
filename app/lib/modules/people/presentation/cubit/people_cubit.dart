import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/shared_navigator.dart';
import '../../domain/usecases/get_people_usecase.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  final GetPeopleUsecase exampleUsecase;
  final SharedNavigator sharedNavigator;
  PeopleCubit(
    this.exampleUsecase,
    this.sharedNavigator,
  ) : super(PeopleState());

  Future exampleCubitCall(String email, String password) async {
    emit(state.copyWith(status: Status.loading));
    final result = await exampleUsecase(PeopleParams(
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
