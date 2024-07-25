import 'package:flutter_modular/flutter_modular.dart';

import '../_shared/app_module.dart';
import '../_shared/data/error_report/errors_report.dart';
import 'data/datasources/example_remote_datasource.dart';
import 'data/repositories/example_repository_impl.dart';
import 'domain/repositories/example_repository.dart';
import 'domain/usecases/get_example_usecase.dart';
import 'presentation/cubit/example_cubit.dart';
import 'presentation/pages/example_page.dart';

class ExampleModule extends Module {
  static const moduleName = '/example';
  
 @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.add<ErrorsReport>(ErrorsReportImpl.new);
    i.addLazySingleton<ExampleRemoteDatasource>(ExampleRemoteDatasourceImpl.new);
    i.addLazySingleton<ExampleRepository>(ExampleRepositoryImpl.new);
    i.addLazySingleton<GetExampleUsecase>(GetExampleUsecase.new);
    i.add<ExampleCubit>(ExampleCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => ExamplePage());
    // r.module('/', module: SplashModule());
    // r.module('/home', module: HomeModule());
    // r.module('/auth', module: AuthModule());
  }
}