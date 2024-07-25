import 'package:flutter_modular/flutter_modular.dart';

import '../_shared/app_module.dart';
import 'presentation/controllers/splash_controller.dart';
import 'presentation/pages/splash_page.dart';

class SplashModule extends Module {
  static const moduleName = '/splash';

  @override
  void binds(i) {
    // i.addSingleton(SharedNavigator.new); // nao era para ter que precisar colocar isso aqui
    // i.add((i) => SplashController( sharedNavigator: i<SharedNavigator>()));
    // i.addSingleton<SharedNavigator>(SharedNavigator.new);
    i.add<SplashController>(SplashController.new);
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child('/', child: (context) => const SplashPage());
  }
}
