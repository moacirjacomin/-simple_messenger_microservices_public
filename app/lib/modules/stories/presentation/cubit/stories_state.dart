part of 'stories_cubit.dart';

class StoriesState extends Equatable {
  final Status status;
  final Failure? failure;
  final String? errorMessage;

  const StoriesState({this.status = Status.initial, this.failure, this.errorMessage = ''});

  @override
  List<Object?> get props => [
        status,
        failure,
        errorMessage,
      ];

  StoriesState copyWith({
    Status? status,
    Failure? failure,
    String? errorMessage,
  }) {
    return StoriesState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
