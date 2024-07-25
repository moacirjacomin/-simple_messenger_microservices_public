import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/presentation/mixins/loader_mixin.dart';
import '../../../_shared/presentation/mixins/message_mixin.dart';
import '../../call_module.dart';
import '../cubit/call_cubit.dart';

class CallPage extends StatefulWidget {
  static const routeName = '/example';
  static const routePath = '${CallModule.moduleName}$routeName';
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> with Loader, Messages {
  var cubit = Modular.get<CallCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call'),
      ),
      body: BlocConsumer<CallCubit, CallState>(
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
