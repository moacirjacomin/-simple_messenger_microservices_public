import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../_shared/config/app_config.dart';
import '../../../_shared/constants/status.dart';
import '../../../_shared/presentation/mixins/loader_mixin.dart';
import '../../../_shared/presentation/mixins/message_mixin.dart';
import '../../../_shared/presentation/widgets/darkmode_toggle_widget.dart';
import '../cubit/home_cubit.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/friend_tile_widget.dart';
import '../widgets/user_offline_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  late var cubit;
  @override
  void initState() {
    super.initState();
    cubit = Modular.get<HomeCubit>();

    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    // var sufix = const String.fromEnvironment('SUFIX', defaultValue: 'NADA');
    // return Center(child: Container(child: Text('HOME'),),);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          const DarkModeToggleWidget(),
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              ...AppConfig()
                  .languages
                  .map((lang) => PopupMenuItem<Locale>(
                        value: lang.locale,
                        child: Text(lang.acronym).tr(),
                      ))
                  .toList(),
            ];
          }, onSelected: (value) {
            print('... selectionado: $value ');
            context.setLocale(value);
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<HomeCubit, HomeState>(
          bloc: cubit,
          listener: (context, state) {
            switch (state.status) {
              case Status.loading:
                showLoader();
                break;
              case Status.failure:
                hideLoader();
                showError(state.message ?? 'Some error');
                break;
              case Status.success:
                hideLoader();
                // cubit.doSomething();
                break;
              case Status.initial:
                // cubit.loadSomenthing()
                break;
              case null:
                break;
            }
          },
          builder: (context, state) {
            if (state.status == Status.success && state.friends.isEmpty) {
              return EmptyListWidget();
            }

            if (state.friends.isNotEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.friends.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(0,8,0,5),
                          child: FriendTileWidget(
                            onTap: (){
                              cubit.onTapOpenChat(state.friends[index]);
                            },
                                friend: state.friends[index],
                              ),
                        )),
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Modular.get<AppCubit>().testSocket();
                  //     },
                  //     child: Text('test')),
                ],
              );
            }

            if(state.status == Status.failure){
              return UserIsOfflineWidget(
                onTapRetry: () async{
                  await cubit.onInit();
                }
              );
            }

            return Text('OI');
          },
        ),
      ),

      // Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     TextButton(
      //       onPressed: cubit.testAppCubit,
      //       child: const Text('testar AppCubit'),
      //     ),
      //     TextButton(
      //       onPressed: cubit.toggleDarkMode,
      //       child: const Text('Toggle isDark'),
      //     ),
      //     TextButton(
      //       onPressed: cubit.logout,
      //       child: const Text(
      //         'efetuar logout',
      //         style: TextStyle(color: Colors.red),
      //       ),
      //     ),
      //     Text(
      //       sufix,
      //       style: const TextStyle(color: Colors.black),
      //     ),
      //     Text('Brilho do sistema: ${MediaQuery.of(context).platformBrightness}'),
      //     const Text(String.fromEnvironment('SUFIX') == 'dev' ? 'WORKS' : 'OPS, no no'),
      //     Text('base url: ' + AppNetwork().baseUrl),
      //     //
      //     //
      //     const SizedBox(
      //       height: 30,
      //     ),
      //     Text('Localization:\n correte: ${context.locale.toString()}'),
      //     Text('msg: ' + 'msg'.tr()),
      //     const Text('msg_named').tr(namedArgs: {'lang': 'UmArgument'}),
      //   ],
      // ),
    );
  }
}
