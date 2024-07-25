import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../firebase_options.dart';
import 'config/app_config.dart';
import 'data/push_notification/fcm_config.dart';
import 'data/push_notification/message_behaviors/order_message_behavior.dart';
import 'data/push_notification/push_notification_handler.dart';

class AppInitializers {
  static Future init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Firebase
    final fcmConfig = FCMConfig();
    final appName = AppConfig().appName;
    await fcmConfig.init(
      messageBehaviors: [OrderMessageBehavior()],
      onBackgroundMessage: firebaseMessagingBackgroundHandler,
      androidChannelId: appName,
      androidChannelName: '$appName Channel',
      androidChannelDescription: appName,
      appAndroidIcon: '@mipmap/ic_notification',
      displayInForeground: Platform.isAndroid,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);

    // fcmConfig.getToken().then(print);
    var FCMtoken = await fcmConfig.getToken() ;
    print('App Initializer - Token FCM: $FCMtoken ');

    // // Hive
    // await Hive.initFlutter();
    // await Hive.openBox(CoreStrings.configs.configsBoxName);
    // await CoreInitializer.init();

    //Internationalization
    // Intl.defaultLocale = const AppConfig().defaultLocal;
  }
}
