part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final Status status;
  final Failure? failure;
  final String? errorMessage;
  final String? name;
  final String? picture;
  final bool allowNotification;
  final String? appVersion;

  ProfileState({
    this.status = Status.initial,
    this.failure,
    this.errorMessage = '',
    this.name,
    this.picture,
    this.allowNotification = true,
    this.appVersion = '0.1'
  });

  @override
  List<Object?> get props => [
        status,
        failure,
        errorMessage,
        name,
        picture,
        allowNotification,
        appVersion
      ];

  ProfileState copyWith({
    Status? status,
    Failure? failure,
    String? errorMessage,
    String? name,
    String? picture,
    bool? allowNotification,
    String? appVersion,
  }) {
    return ProfileState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      allowNotification: allowNotification ?? this.allowNotification,
      appVersion: appVersion ?? this.appVersion,
    );
  }
}
