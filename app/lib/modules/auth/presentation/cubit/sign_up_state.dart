part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final Status status;
  final Failure? failure;
  final bool isCpfChecked;

  const SignUpState({
    this.status = Status.initial,
    this.isCpfChecked = false,
    this.failure,
  });

  @override
  List<Object?> get props => [status, failure];

  SignUpState copyWith({
    Status? status,
    Failure? failure,
    bool? isCpfChecked,
  }) {
    return SignUpState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      isCpfChecked: isCpfChecked ?? this.isCpfChecked,
    );
  }
}
