part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Status? status;
  final List<FriendModel> friends;
  final String message;
  
  const HomeState({
    this.status = Status.initial,
    this.friends = const [],
    this.message = "",
  });

  @override
  List<Object?> get props => [
        status,
        friends,
        message,
      ];

  HomeState copyWith({
    Status? status,
    List<FriendModel>? friends,
    String? message,
  }) {
    return HomeState(
      status: status ?? this.status,
      friends: friends ?? this.friends,
      message: message ?? this.message,
    );
  }
}
