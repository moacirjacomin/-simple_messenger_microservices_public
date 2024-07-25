import 'package:flutter_modular/flutter_modular.dart';

import '../../../_shared/presentation/cubit/app_cubit.dart';
import '../../../_shared/shared_navigator.dart';

class SplashController {
  final SharedNavigator sharedNavigator;

  SplashController({
    required this.sharedNavigator,
  });

  Future onInit() async {
    print('... SPLASH CUBIT - onInit');
    await Future.delayed(const Duration(milliseconds: 800));

    final user = await Modular.get<AppCubit>().getCurrentUser();
    print('... SPLASH CUBIT currentUser=${user}');
    if (user != null) {
      return sharedNavigator.openHome();
    } else {
      return sharedNavigator.openLogin();
    }

  }

  void testNavigateHome() {
    return sharedNavigator.openHome();
  }
}
