import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../_shared/presentation/cubit/app_cubit.dart';
import 'notification_element_widget.dart';

class DarkModeToggleProfileWidget extends StatefulWidget {
  const DarkModeToggleProfileWidget({super.key});

  @override
  State<DarkModeToggleProfileWidget> createState() => _DarkModeToggleProfileWidgetState();
}

class _DarkModeToggleProfileWidgetState extends State<DarkModeToggleProfileWidget> {
  late AppCubit appCubit;

  @override
  void initState() {
    super.initState();

    appCubit = Modular.get<AppCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      bloc: appCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return NotificationElement(
          isAvailable: !state.isDarkMode,
          onChange: (value) {
            // print('newValue=${value}');
            appCubit.toggleDarkMode();
          },
          // icon: LineIcons.lightbulbAlt,
          icon: !state.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          title: 'Modo Escuro/Claro',
          subTitleOn: 'Luz Acessa',
          subTitleOff: 'Luz Apagada',
        );

        // IconButton(
        //   onPressed: appCubit.toggleDarkMode,
        //   icon: Icon(
        //     state.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        //   ),
        // );
      },
    );
  }
}
