part of 'user_edit_cubit.dart';

class UserEditState extends Equatable {
  final Status status;
  final Failure? failure;
  final String? errorMessage;
  final String? name;
  final String? email;
  final String? picture;


  UserEditState({
    this.status = Status.initial,
    this.failure,
    this.errorMessage = '',
    this.name,
    this.email,
    this.picture,
  });

  @override
  List<Object?> get props => [
    status,
    failure,
    errorMessage,
    name,
    email,
    picture
  ];

  UserEditState copyWith({
    Status? status,
    Failure? failure,
    String? errorMessage,
    String? name,
    String? email,
    String? picture,
  }) {
    return UserEditState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
      name: name ?? this.name,
      email: email ?? this.email,
      picture: picture ?? this.picture, 
    );
  }
}

 
