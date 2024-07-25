import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/presentation/mixins/loader_mixin.dart';
import '../../../_shared/presentation/mixins/message_mixin.dart';
import '../../stories_module.dart';
import '../cubit/stories_cubit.dart';

class StoriesPage extends StatefulWidget {
  static const routeName = '/example';
  static const routePath = '${StoriesModule.moduleName}$routeName';
  const StoriesPage({super.key});

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> with Loader, Messages {
  var cubit = Modular.get<StoriesCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stories'),
      ),
      body: BlocConsumer<StoriesCubit, StoriesState>(
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
            return  Text(state.status.toString());
          }),
    );
  }
}
