part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final Status status;
  final Failure? failure;

  const SignInState({
    this.status = Status.initial,
    this.failure,
  });

  @override
  List<Object?> get props => [status, failure];

  SignInState copyWith({
    Status? status,
    Failure? failure,
  }) {
    return SignInState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}