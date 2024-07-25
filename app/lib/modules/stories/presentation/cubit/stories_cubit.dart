import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/shared_navigator.dart';
import '../../domain/usecases/get_storie_usecase.dart';

part 'stories_state.dart';

class StoriesCubit extends Cubit<StoriesState> {
  final GetStoriesUsecase exampleUsecase;
  final SharedNavigator sharedNavigator;
  StoriesCubit(
    this.exampleUsecase,
    this.sharedNavigator,
  ) : super(const StoriesState());

  Future exampleCubitCall(String email, String password) async {
    emit(state.copyWith(status: Status.loading));
    final result = await exampleUsecase(StoriesParams(
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
