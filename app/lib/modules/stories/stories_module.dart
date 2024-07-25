import 'package:flutter_modular/flutter_modular.dart';

import '../_shared/app_module.dart';
import '../_shared/data/error_report/errors_report.dart';
import 'data/datasources/stories_local_datasource.dart';
import 'data/datasources/stories_remote_datasource.dart';
import 'data/repositories/example_repository_impl.dart';
import 'domain/repositories/stories_repository.dart';
import 'domain/usecases/get_storie_usecase.dart';
import 'presentation/cubit/stories_cubit.dart';
import 'presentation/pages/stories_page.dart';

class StoriesModule extends Module {
  static const moduleName = '/example';
  
 @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.add<ErrorsReport>(ErrorsReportImpl.new);
    i.addLazySingleton<StoriesLocalDatasource>(StoriesLocalDatasourceImpl.new);
    i.addLazySingleton<StoriesRemoteDatasource>(StoriesRemoteDatasourceImpl.new);
    i.addLazySingleton<StoriesRepository>(StoriesRepositoryImpl.new);
    i.addLazySingleton<GetStoriesUsecase>(GetStoriesUsecase.new);
    i.add<StoriesCubit>(StoriesCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const StoriesPage());
    // r.module('/', module: SplashModule());
    // r.module('/home', module: HomeModule());
    // r.module('/auth', module: AuthModule());
  }
}