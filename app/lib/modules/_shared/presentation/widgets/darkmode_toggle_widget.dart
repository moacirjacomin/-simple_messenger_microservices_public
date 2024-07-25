import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../cubit/app_cubit.dart';

class DarkModeToggleWidget extends StatefulWidget {
  const DarkModeToggleWidget({super.key});

  @override
  State<DarkModeToggleWidget> createState() => _DarkModeToggleWidgetState();
}

class _DarkModeToggleWidgetState extends State<DarkModeToggleWidget> {
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
      listener: (context, state) { },
      builder: (context, state) {
        return IconButton(
          onPressed: appCubit.toggleDarkMode,
          icon: Icon(
            state.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          ),
        );
      },
    );
  }
}
