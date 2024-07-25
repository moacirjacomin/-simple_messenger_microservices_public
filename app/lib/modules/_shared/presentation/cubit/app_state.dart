part of 'app_cubit.dart';

class AppState extends Equatable {
  final bool isDarkMode;

  final List<int> activeFriends;
  final List<ConversationModel> conversations;
  final List<MessageModel> messages;
  final bool appIsOpen;

  const AppState({
    this.isDarkMode = false,
    this.activeFriends = const [],
    this.conversations = const [],
    this.messages = const [],
    this.appIsOpen = true,
  });

  @override
  List<Object> get props => [isDarkMode, activeFriends, conversations, messages, appIsOpen];

  AppState copyWith({
    bool? isDarkMode,
    List<int>? activeFriends,
    List<ConversationModel>? conversations,
    List<MessageModel>? messages,
    bool? appIsOpen,
    }) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      activeFriends: activeFriends ?? this.activeFriends,
      conversations: conversations ?? this.conversations,
      messages: messages ?? this.messages,
      appIsOpen: appIsOpen ?? this.appIsOpen,
    );
  }
}
