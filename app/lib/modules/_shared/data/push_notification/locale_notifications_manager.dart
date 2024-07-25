// ignore_for_file: unused_element

import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'fcm_extension.dart';

class LocaleNotificationManager {
  static final StreamController<RemoteMessage> onLocaleClick =
      StreamController<RemoteMessage>.broadcast();

  static Future _onPayLoad(String? payload) async {
    if (payload == null) return;
    var message = RemoteMessage.fromMap(jsonDecode(payload));
    onLocaleClick.add(message);
  }

  // static Future<RemoteMessage?> getInitialMessage() async {
  //   var _localeNotification = FlutterLocalNotificationsPlugin();
  //   var payload = await _localeNotification.getNotificationAppLaunchDetails();
  //   if (payload != null && payload.didNotificationLaunchApp) {
  //     return RemoteMessage.fromMap(jsonDecode(payload ?? ''));
  //   }
  //   return null;
  // }

  static Future init(
    /// Drawable icon works only in forground
    String? appAndroidIcon,

    /// Required to show head up notification in foreground
    String? androidChannelId,

    /// Required to show head up notification in foreground
    String? androidChannelName,

    /// Required to show head up notification in foreground
    String? androidChannelDescription,
  ) async {
    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    //! Android settings
    var initializationSettingsAndroid = AndroidInitializationSettings(
      appAndroidIcon ?? '@mipmap/ic_launcher',
    );
    //! Ios setings
    const  initializationSettingsIOS =   DarwinInitializationSettings();
    //! macos setings
    // final initializationSettingsMac = MacOSInitializationSettings();

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      // macOS: initializationSettingsMac,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: _onPayLoad,
    );
  }

  static void displayNotification(RemoteMessage _notification, String? androidChannelId,
      String? androidChannelName, String? androidChannelDescription,
      [int? id]) {
    if (_notification.notification == null) return;
    var _localeNotification = FlutterLocalNotificationsPlugin();
    var smallIcon = _notification.notification?.android?.smallIcon;

    //! Android settings
    var _android = AndroidNotificationDetails(
      androidChannelId ?? _notification.notification?.android?.channelId ?? 'FCM_Config',
      androidChannelName ?? _notification.notification?.android?.channelId ?? 'FCM_Config',
      // androidChannelDescription ?? _notification.notification?.android?.channelId ?? 'FCM_Config',
      importance: _getImportance(_notification.notification!),
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(
        _notification.notification?.body ?? '',
        htmlFormatBigText: true,
      ),
      ticker: _notification.notification?.android?.ticker,
      icon: smallIcon == 'default' ? null : smallIcon,
      // category: _notification.category,
      groupKey: _notification.collapseKey,
      showProgress: false,
      sound: _notification.isDefaultAndroidSound
          ? null
          : (_notification.isAndroidRemoteSound
              ? UriAndroidNotificationSound(_notification.notification!.android!.sound!)
              : RawResourceAndroidNotificationSound(_notification.notification!.android!.sound)),
    );
    var badge = int.tryParse(_notification.notification?.apple?.badge ?? '');
    var _ios = DarwinNotificationDetails(
      threadIdentifier: _notification.collapseKey,
      sound: _notification.notification?.apple?.sound?.name,
      badgeNumber: badge,
      subtitle: _notification.notification?.apple?.subtitle,
      presentBadge: badge == null ? null : true,
    );
    var _mac = DarwinNotificationDetails(
      threadIdentifier: _notification.collapseKey,
      sound: _notification.notification?.apple?.sound?.name,
      badgeNumber: badge,
      subtitle: _notification.notification?.apple?.subtitle,
      presentBadge: badge == null ? null : true,
    );
    var _details = NotificationDetails(
      android: _android,
      iOS: _ios,
      macOS: _mac,
    );
    var _id = id ?? DateTime.now().difference(DateTime(2021)).inSeconds;
    _localeNotification.show(
      _id,
      _notification.notification!.title,
      _notification.notification!.body,
      _details,
      payload: jsonEncode(_notification.toMap()),
    );
  }

  static Importance _getImportance(RemoteNotification notification) {
    if (notification.android?.priority == null) return Importance.high;
    switch (notification.android!.priority) {
      case AndroidNotificationPriority.minimumPriority:
        return Importance.min;
      case AndroidNotificationPriority.lowPriority:
        return Importance.low;
      case AndroidNotificationPriority.defaultPriority:
        return Importance.defaultImportance;
      case AndroidNotificationPriority.highPriority:
        return Importance.high;
      case AndroidNotificationPriority.maximumPriority:
        return Importance.max;
      default:
        return Importance.max;
    }
  }
}
