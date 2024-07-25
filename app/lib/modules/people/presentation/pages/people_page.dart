import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/presentation/mixins/loader_mixin.dart';
import '../../../_shared/presentation/mixins/message_mixin.dart';
import '../../people_module.dart';
import '../cubit/people_cubit.dart';

class PeoplePage extends StatefulWidget {
  static const routeName = '/example';
  static const routePath = '${PeopleModule.moduleName}$routeName';
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> with Loader, Messages {
  var cubit = Modular.get<PeopleCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),
      body: BlocConsumer<PeopleCubit, PeopleState>(
          bloc: cubit,
          listener: (context, state) {
            switch (state.status) {
              case Status.loading:
                showLoader();
                break;
              case Status.failure:
                hideLoader();
                showError(state.errorMessage ?? 'Some error');
                break;
              case Status.success:
                hideLoader();
                // cubit.doSomething();
                break;
              case Status.initial:
                // cubit.loadSomenthing()
                break;
            }
          },
          builder: (context, state) {
            return  Container(
              child: Text(state.status.toString()),
            );
          }),
    );
  }
}
