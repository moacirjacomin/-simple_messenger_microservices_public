import 'package:flutter_modular/flutter_modular.dart';

import '../_shared/app_module.dart';
import '../_shared/data/error_report/errors_report.dart';
import 'data/datasources/call_local_datasource.dart';
import 'data/datasources/call_remote_datasource.dart';
import 'data/repositories/call_repository_impl.dart';
import 'domain/repositories/call_repository.dart';
import 'domain/usecases/get_call_usecase.dart';
import 'presentation/cubit/call_cubit.dart';
import 'presentation/pages/call_page.dart';

class CallModule extends Module {
  static const moduleName = '/example';
  
 @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.add<ErrorsReport>(ErrorsReportImpl.new);
    i.addLazySingleton<CallLocalDatasource>(CallLocalDatasourceImpl.new);
    i.addLazySingleton<CallRemoteDatasource>(CallRemoteDatasourceImpl.new);
    i.addLazySingleton<CallRepository>(CallRepositoryImpl.new);
    i.addLazySingleton<GetCallUsecase>(GetCallUsecase.new);
    i.add<CallCubit>(CallCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => CallPage());
    // r.module('/', module: SplashModule());
    // r.module('/home', module: HomeModule());
    // r.module('/auth', module: AuthModule());
  }
}