import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/_shared/app_initializers.dart';
import 'modules/_shared/app_module.dart';
import 'modules/_shared/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // runZonedGuarded(
  //   () async {
  // WidgetsFlutterBinding.ensureInitialized();
  await AppInitializers.init();

  return runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('pt', 'BR')],
      path: 'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en', 'US'),
      child: 
      ModularApp(
        
        debugMode: true,
        module: AppModule(),
        child: const AppWidget(),
      ),
    ),

    // },
    // FirebaseCrashlytics.instance.recordError,
  );
}