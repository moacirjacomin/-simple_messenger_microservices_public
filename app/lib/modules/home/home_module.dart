import 'package:flutter_modular/flutter_modular.dart';

import '../_shared/app_module.dart';
import '../_shared/data/error_report/errors_report.dart';
import 'data/datasources/home_local_datasource.dart';
import 'data/datasources/home_remote_datasource.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/get_friends_usecase.dart';
import 'presentation/cubit/chat_cubit.dart';
import 'presentation/cubit/home_cubit.dart';
import 'presentation/pages/chat_page.dart';
import 'presentation/pages/home_page.dart';

class HomeModule extends Module {
  static const moduleName = '/chat';

  @override
  void binds(i) {
    i.add<ErrorsReport>(ErrorsReportImpl.new);
    i.addLazySingleton<HomeLocalDatasource>(HomeLocalDatasourceImpl.new);
    i.addLazySingleton<HomeRemoteDatasource>(HomeRemoteDatasourceImpl.new);
    i.addLazySingleton<HomeRepository>(HomeRepositoryImpl.new);
    i.addSingleton<GetFriendsUsecase>(GetFriendsUsecase.new);
    i.add<HomeCubit>(HomeCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
    i.add<ChatCubit>(ChatCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
    r.child('/room', child: (context) => ChatPage(friend: r.args.data), transition: TransitionType.noTransition);
  }
}
