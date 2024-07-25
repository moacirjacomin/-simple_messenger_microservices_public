part of 'example_cubit.dart';

class ExampleState extends Equatable {
  final Status status;
  final Failure? failure;
  final String? errorMessage;

  ExampleState({this.status = Status.initial, this.failure, this.errorMessage = ''});

  @override
  List<Object?> get props => [
        status,
        failure,
        errorMessage,
      ];

  ExampleState copyWith({
    Status? status,
    Failure? failure,
    String? errorMessage,
  }) {
    return ExampleState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
