import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/shared_navigator.dart';
import '../../domain/usecases/get_example_usecase.dart';

part 'example_state.dart';

class ExampleCubit extends Cubit<ExampleState> {
  final GetExampleUsecase exampleUsecase;
  final SharedNavigator sharedNavigator;
  ExampleCubit(
    this.exampleUsecase,
    this.sharedNavigator,
  ) : super(ExampleState());

  Future exampleCubitCall(String email, String password) async {
    emit(state.copyWith(status: Status.loading));
    final result = await exampleUsecase(ExampleParams(
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
