import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'constants/app_styles.dart';
import 'data/storage/local_storage_secure.dart';
import 'presentation/cubit/app_cubit.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  late AppCubit appCubit;

  AppLifecycleState? _appLifecycleState;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print('... LIFECICLE CHANGED: DISPOSOU ');
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appLifecycleState = state;
      print('... LIFECICLE CHANGED: ${_appLifecycleState}');

      appCubit.updateOnlineStatus(_appLifecycleState == AppLifecycleState.resumed);
      appCubit.updateAppIsOpen(_appLifecycleState == AppLifecycleState.resumed);
    });

    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    appCubit = Modular.get<AppCubit>();

    initialize();
  }

  Future<void> initialize() async {
    await Modular.get<LocalStorage>().init();

    // get system default value for dark/ligth mode, to be initial value
    // ignore: use_build_context_synchronously
    var defaultBrightness = MediaQuery.of(context).platformBrightness;
    appCubit.onInit(defaultBrightness != Brightness.light);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      bloc: appCubit,
      builder: (context, state) {
        print('... MATERIAL state.isDarkMode=${state.isDarkMode} currentAppState: ${_appLifecycleState}');
        return MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          //
          title: 'Simple Messenger',
          debugShowCheckedModeBanner: false,
          theme: ThemeConfig.selector(state.isDarkMode, context),
          //
          routerConfig: Modular.routerConfig,
        );
      },
    ); //added by extension
  }
}
