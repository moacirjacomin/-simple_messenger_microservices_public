import 'package:flutter_modular/flutter_modular.dart';

import '../_shared/app_module.dart';
import '../_shared/data/error_report/errors_report.dart';
import 'data/datasources/profile_local_datasource.dart';
import 'data/datasources/profile_remote_datasource.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/get_profile_usecase.dart';
import 'domain/usecases/get_version_usecase.dart';
import 'domain/usecases/update_allow_notification_usecase.dart';
import 'presentation/cubit/profile_cubit.dart';
import 'presentation/cubit/user_edit_cubit.dart';
import 'presentation/pages/profile_page.dart';
import 'presentation/pages/user_edit_page.dart';

class ProfileModule extends Module {
  static const moduleName = '/profile';
  
 @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.add<ErrorsReport>(ErrorsReportImpl.new);
    i.addLazySingleton<ProfileLocalDatasource>(ProfileLocalDatasourceImpl.new);
    i.addLazySingleton<ProfileRemoteDatasource>(ProfileRemoteDatasourceImpl.new);
    i.addLazySingleton<ProfileRepository>(ProfileRepositoryImpl.new);
    i.addLazySingleton<GetProfileUsecase>(GetProfileUsecase.new);
    i.addLazySingleton<GetVersionUsecase>(GetVersionUsecase.new);
    i.addLazySingleton<UpdateAllowNotificationUsecase>(UpdateAllowNotificationUsecase.new);
    i.add<ProfileCubit>(ProfileCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
    i.add<UserEditCubit>(UserEditCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const ProfilePage());
    r.child('/user_edit', child: (context) => const UserEditPage(), transition: TransitionType.noTransition);
    // r.module('/', module: SplashModule());
    // r.module('/home', module: HomeModule());
    // r.module('/auth', module: AuthModule());
  }
}