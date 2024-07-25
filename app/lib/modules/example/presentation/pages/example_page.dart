import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/presentation/mixins/loader_mixin.dart';
import '../../../_shared/presentation/mixins/message_mixin.dart';
import '../../example_module.dart';
import '../cubit/example_cubit.dart';

class ExamplePage extends StatefulWidget {
  static const routeName = '/example';
  static const routePath = '${ExampleModule.moduleName}$routeName';
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> with Loader, Messages {
  var cubit = Modular.get<ExampleCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: BlocConsumer<ExampleCubit, ExampleState>(
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
