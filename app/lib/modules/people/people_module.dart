import 'package:flutter_modular/flutter_modular.dart';

import '../_shared/app_module.dart';
import '../_shared/data/error_report/errors_report.dart';
import 'data/datasources/people_local_datasource.dart';
import 'data/datasources/people_remote_datasource.dart';
import 'data/repositories/people_repository_impl.dart';
import 'domain/repositories/people_repository.dart';
import 'domain/usecases/get_people_usecase.dart';
import 'presentation/cubit/people_cubit.dart';
import 'presentation/pages/people_page.dart';

class PeopleModule extends Module {
  static const moduleName = '/people';
  
 @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.add<ErrorsReport>(ErrorsReportImpl.new);
    i.addLazySingleton<PeopleLocalDatasource>(PeopleLocalDatasourceImpl.new);
    i.addLazySingleton<PeopleRemoteDatasource>(PeopleRemoteDatasourceImpl.new);
    i.addLazySingleton<PeopleRepository>(PeopleRepositoryImpl.new);
    i.addLazySingleton<GetPeopleUsecase>(GetPeopleUsecase.new);
    i.add<PeopleCubit>(PeopleCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => PeoplePage());
    // r.module('/', module: SplashModule());
    // r.module('/home', module: HomeModule());
    // r.module('/auth', module: AuthModule());
  }
}