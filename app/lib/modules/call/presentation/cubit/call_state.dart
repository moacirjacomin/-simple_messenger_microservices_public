part of 'call_cubit.dart';

class CallState extends Equatable {
  final Status status;
  final Failure? failure;
  final String? errorMessage;

  CallState({this.status = Status.initial, this.failure, this.errorMessage = ''});

  @override
  List<Object?> get props => [
        status,
        failure,
        errorMessage,
      ];

  CallState copyWith({
    Status? status,
    Failure? failure,
    String? errorMessage,
  }) {
    return CallState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
