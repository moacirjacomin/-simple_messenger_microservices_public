import 'package:flutter_modular/flutter_modular.dart';

import '../_layout/layout_shared.dart';
import '../auth/auth_module.dart';
import '../call/call_module.dart';
import '../home/home_module.dart';
import '../people/people_module.dart';
import '../profle/profile_module.dart';
import '../splash/splash_module.dart';
import '../stories/stories_module.dart';
import 'data/datasources/core_local_datasource.dart';
import 'constants/app_network.dart';
import 'data/network/logged_dio.dart';
import 'data/network/logged_interceptor.dart';
import 'data/network/not_logged_dio.dart';
import 'data/network/not_logged_interceptor.dart';
import 'data/repositories/core_repository_impl.dart';
import 'data/storage/local_storage.dart';
import 'data/storage/local_storage_secure.dart';
import 'domain/repositories/core_repository.dart';
import 'domain/usecases/authentication/get_current_user_usecase.dart';
import 'domain/usecases/authentication/logout_usecase.dart';
import 'domain/usecases/authentication/update_auth_user_usecase.dart';
import '../auth/domain/usecases/update_push_token_user_usecase.dart';
import 'domain/usecases/theming/is_dark_theme_usecase.dart';
import 'domain/usecases/theming/toggle_theme_usecase.dart';
import 'presentation/cubit/app_cubit.dart';
import 'shared_actions.dart';
import 'shared_navigator.dart';

final class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) => i
    ..addSingleton<AppNetwork>(() => AppNetwork())
    ..addSingleton<SharedNavigator>(SharedNavigator.new)
    ..addSingleton<SharedActions>(SharedActionsImpl.new)
    ..addSingleton<LocalStorage>(() => LocalStorage.getInstance()..init())
    ..addSingleton<LocalStorageSecure>(() => LocalStorageSecure.getInstance())
    ..addSingleton<CoreLocalDataSource>(CoreLocalDataSourceImpl.new)
    ..addSingleton<LoggedInterceptor>(LoggedInterceptor.new)
    ..addSingleton<LoggedDio>(LoggedDio.new)
    ..addSingleton<NotLoggedInterceptor>(NotLoggedInterceptor.new)
    ..addSingleton<NotLoggedDio>(NotLoggedDio.new)
    ..addSingleton<CoreRepository>(CoreRepositoryImpl.new)
    ..addSingleton<LogoutUsecase>(LogoutUsecase.new)
    ..addSingleton<GetCurrentUserUsecase>(GetCurrentUserUsecase.new);

  

  // ..addInstance<LocalStorageSecure>(LocalStorageSecure.getInstance());
  // ..addLazySingleton<CustomDio>(CustomDio.new)
  // ..addLazySingleton<PaymentTypeRepository>(PaymentTypeRepositoryImpl.new)
  // ..addLazySingleton<ProductsRepository>(ProductsRepositoryImpl.new)
  // ..addLazySingleton<UserRepository>(UserRepositoryImpl.new);
}

class AppModule extends Module {
  AppModule();

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.add<UpdateCurrentUserUsecase>(UpdateCurrentUserUsecase.new);
    i.add<IsDarkThemeUseCase>(IsDarkThemeUseCase.new);
    i.add<ToggleThemeUseCase>(ToggleThemeUseCase.new);
    i.add<UpdatePushTokenUserUsecase>(UpdatePushTokenUserUsecase.new);
    i.addSingleton<AppCubit>(AppCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
  }

  @override
  void routes(r) {
    r.module('/', module: SplashModule());
    r.module('/auth', module: AuthModule());
    r.child('/home',
        child: (context) => const LayoutShared(
              body: RouterOutlet(),
            ),
        transition: TransitionType.upToDown,
        children: [
          ModuleRoute('/chat', module: HomeModule()),
          ModuleRoute('/people', module: PeopleModule()),
          ModuleRoute('/call', module: CallModule()),
          ModuleRoute('/stories', module: StoriesModule()),
          ModuleRoute('/profile', module: ProfileModule()),
          // WildcardRoute(child: (context) => NotFoundPage()),
        ]);
  }
}
