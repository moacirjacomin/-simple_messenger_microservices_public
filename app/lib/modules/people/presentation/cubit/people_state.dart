part of 'people_cubit.dart';

class PeopleState extends Equatable {
  final Status status;
  final Failure? failure;
  final String? errorMessage;

  const PeopleState({this.status = Status.initial, this.failure, this.errorMessage = ''});

  @override
  List<Object?> get props => [
        status,
        failure,
        errorMessage,
      ];

  PeopleState copyWith({
    Status? status,
    Failure? failure,
    String? errorMessage,
  }) {
    return PeopleState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
