import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../home/data/models/conversation_model.dart';
import '../../../home/data/models/message_model.dart';
import '../../config/app_config.dart';
import '../../domain/entities/current_user.dart';
import '../../domain/usecases/authentication/get_current_user_usecase.dart';
import '../../domain/usecases/authentication/logout_usecase.dart';
import '../../domain/usecases/authentication/update_auth_user_usecase.dart';
import '../../domain/usecases/theming/is_dark_theme_usecase.dart';
import '../../domain/usecases/theming/toggle_theme_usecase.dart';
import '../../shared_navigator.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final UpdateCurrentUserUsecase updateCurrentUserUsecase;
  final IsDarkThemeUseCase isDarkThemeUseCase;
  final ToggleThemeUseCase toggleThemeUseCase;
  final LogoutUsecase logoutUsecase;
  final SharedNavigator sharedNavigator;

  late Socket socketPresence;
  late Socket socketChat;
  late final _currentUser;
  Timer? _periodicPinger;

  AppCubit(
    this.getCurrentUserUsecase,
    this.updateCurrentUserUsecase,
    this.isDarkThemeUseCase,
    this.toggleThemeUseCase,
    this.logoutUsecase,
    this.sharedNavigator,
  ) : super(const AppState());

  void onInit([bool? isDarkModeDefaultValue]) async {
    print('... CUBIT init isDarkModeDefaultValue=$isDarkModeDefaultValue');

    // Get dark/light mode from localStorage
    var isDark = isDarkThemeUseCase(isDarkModeDefaultValue);
    emit(AppState(isDarkMode: isDark));

    // Get current user
    this._currentUser = await getCurrentUser();

    print('... CUBIT init _currentUser=$_currentUser');
    if (this._currentUser == null) return;

    // Socket initialization
    _setupPresenceSocket();
    _setupChatSocket();
  }

  void testSocket() {
    socketPresence.connect();
  }

  void onAppClose() {
    _periodicPinger?.cancel();

    socketPresence.emit('updateActiveStatus', false);
    socketPresence.off('friendActive');
    socketPresence.disconnect();

    socketChat.off('newMessage');
    socketChat.off('getAllConversations');
    socketChat.disconnect();
  }

  void updateAppIsOpen(bool newValue) {
    print('... APP CUBIT updateAppIsOpen newValue=$newValue ');

    if (newValue == true) {
      _periodicPinger?.cancel();
    } else {
      if (_periodicPinger == null) {
        // to be sure that only one will be create
        startSocketPinger();
      }
    }

    emit(state.copyWith(appIsOpen: newValue));
  }

  Future toggleDarkMode() async {
    toggleThemeUseCase();
    // emit(AppState(isDarkMode: !state.isDarkMode));
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  Future<CurrentUser?> getCurrentUser() async {
    // await Future.delayed(const Duration(seconds: 4));
    return getCurrentUserUsecase();
  }

  void updateCurrentUser(CurrentUser newValue) {
    print('... APP CUBIT updateCurrentUser - newValue=${newValue}');
    updateCurrentUserUsecase(newValue);
  }

  void logout() {
    print('... APP CUBIT - logout runs');
    logoutUsecase();
    sharedNavigator.openLogin();
  }

  //
  //
  // PRESENCE #######################################################################
  void _setupPresenceSocket() {
    var baseUrlSocket = const String.fromEnvironment('BASE_URL_SOCKET_PRESENCE');
    if (baseUrlSocket == '' || this._currentUser == null) return;
    print('... CUBIT init _setupPresenceSocket baseUrlSocket=$baseUrlSocket  _currentUser=${this._currentUser}');

    socketPresence = io(
        baseUrlSocket,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'Authorization': 'Bearer ' + this._currentUser!.token}) // optional
            .build());

    socketPresence.onConnect((_) {
      print('... SOCK_PRESENCE: connect');

      socketPresence.emit('updateActiveStatus', true);
    });
    socketPresence.on('event', (data) => print('... SOCK_PRESENCE: ' + data));

    socketPresence.on('friendActive', (data) {
      print('... SOCK_PRESENCE: on=friendActive:: ');
      print(data);
      print(data['isActive'].runtimeType);

      int userId = data['id'] as int;
      bool isActive = data['isActive'].runtimeType == String ? bool.parse(data['isActive']) : data['isActive'] as bool;
      // this cast was this way because during test in postman, isActive is send it as a Text/String

      // data.id  data.isActive
      List<int> currentActiveFriends;
      currentActiveFriends = [...state.activeFriends];

      if (isActive) {
        currentActiveFriends.add(userId);
      } else {
        currentActiveFriends.removeWhere((element) => element == userId);
      }

      print('currentActiveFriends=${currentActiveFriends.toSet().toList()}');

      emit(state.copyWith(activeFriends: [...currentActiveFriends.toSet().toList()]));
    });

    socketPresence.onDisconnect((_) => print('... SOCK_PRESENCE: disconnect'));
    socketPresence.onConnectError((data) => print('... SOCK_PRESENCE: error: ${data}'));

    socketPresence.connect();

    print('... SOCK_PRESENCE: setup done');
  }

  void updateOnlineStatus(bool newStatus) {
    print('... APP CUBIT updateOnlineStatus newStatus=$newStatus');
    socketPresence.emit('updateActiveStatus', newStatus);
  }
  // END OF PRESENCE METHODS ########################################################
  // ################################################################################

  //
  //
  // CHAT ###########################################################################
  void _setupChatSocket() {
    var baseUrlSocket = const String.fromEnvironment('BASE_URL_SOCKET_CHAT');
    print('... CUBIT init _setupChatSocket baseUrlSocket=$baseUrlSocket _currentUser=${this._currentUser}');
    if (baseUrlSocket == '' || this._currentUser == null) return;

    socketChat = io(
        baseUrlSocket,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'Authorization': 'Bearer ' + this._currentUser!.token}) // optional
            .build());

    socketChat.onConnect((_) {
      print('... SOCK_CHAT: connect');
    });

    socketChat.on('friendActive', (data) {
      print('... SOCK_CHAT: on=friendActive:: ');
    });

    socketChat.on('getAllConversations', (data) {
      print('... SOCK_CHAT: on=getAllConversations:: ');
      print(data);
      // print(data['isActive'].runtimeType);

      if (data == null) return;

      var conversations = data.map<ConversationModel>((c) => ConversationModel.fromMap(c)).toList();

      print('... SOCK_CHAT conversations=${conversations}');

      emit(state.copyWith(conversations: conversations));
    });

    socketChat.on('newMessage', (data) {
      print('... SOCK_CHAT: on=newMessage:: ');
      print(data);
      // print(data['isActive'].runtimeType);

      if (data == null) return;

      var message = MessageModel.fromMap(data);

      print('... SOCK_CHAT message=${message} state.appIsOpen=${state.appIsOpen}');

      emit(state.copyWith(messages: [...state.messages, message]));

      if (state.appIsOpen == false) {
        showLocalNotification('New Message', message.message);
      }
    });

    socketChat.onDisconnect((_) => print('... SOCK_CHAT: disconnect'));
    socketChat.onConnectError((data) => print('... SOCK_CHAT: error: ${data}'));

    socketChat.connect();
    socketChat.emit('getConversations');
    print('... SOCK_CHAT: setup done');
  }

  void startSocketPinger() {
    _periodicPinger = Timer.periodic(Duration(seconds: 10), (timer) {
      socketChat.emit('ping');
      print('... SOCK_CHAT: ping');
    });
  }

  void chatSentMessage(String message, int friendId, int conversationId) {
    socketChat.emit('sendMessage', {
      'message': message,
      'friendId': friendId,
      'conversationId': conversationId,
    });

    emit(state.copyWith(messages: [
      ...state.messages,
      MessageModel(
        id: int.parse(_currentUser.id),
        message: message,
        creatorId: int.parse(_currentUser.id),
        conversationId: conversationId,
      ),
    ]));
  }

  int getConversationId(int friendId) {
    print('... getConversationId friendId=${friendId}');
    print('... getConversationId _currentUser.id=${_currentUser.id}');
    print('... getConversationId state.conversations=${state.conversations}\n');

    // print('... getConversationId check1=${state.conversations[0].userIds.contains(int.parse(_currentUser.id))}');
    // print('... getConversationId check2=${state.conversations[0].userIds.contains(friendId)}');
    // print('... getConversationId check1.=${state.conversations[0].userIds[0]}');
    // print('... getConversationId check1.=${state.conversations[0].userIds[0].runtimeType}');

    try {
      ConversationModel? conversartion = state.conversations.firstWhere(
        (element) => (element.userIds.contains(int.parse(_currentUser.id)) && element.userIds.contains(friendId)),
      );

      return conversartion?.id ?? 0;
    } catch (e) {
      return 0;
    }
  }

  // END OF CHAT METHODS ############################################################
  // ################################################################################

  Future<void> showLocalNotification(String title, String body) async {
    final appName = AppConfig().appName;
    var androidChannelId = appName;
    var androidChannelName = '$appName Channel';
    var _localeNotification = FlutterLocalNotificationsPlugin();

    Random random = Random(DateTime.now().millisecondsSinceEpoch);
    int randomNumber = random.nextInt(100);

    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      androidChannelId, // Substitua pelo ID do seu canal de notificação
      androidChannelName, // Substitua pelo nome do seu canal de notificação
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    print('... APP CUBIT showLocalNotification androidChannelId=$androidChannelId androidChannelName=$androidChannelName randomNumber=$randomNumber');

    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await _localeNotification.show(
      randomNumber, // ID da notificação
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
