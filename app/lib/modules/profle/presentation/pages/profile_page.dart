import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:line_icons/line_icons.dart';

import '../../../_shared/constants/core_dimens.dart';
import '../../../_shared/constants/status.dart';
import '../../../_shared/presentation/mixins/loader_mixin.dart';
import '../../../_shared/presentation/mixins/message_mixin.dart';
import '../../../_shared/presentation/widgets/base_scaffold.dart';
import '../../profile_module.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/generic_element_widget.dart';
import '../widgets/notification_element_widget.dart';
import '../widgets/toogle_dark_widget.dart';
import '../widgets/user_picture_widget.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';
  static const routePath = '${ProfileModule.moduleName}$routeName';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with Loader, Messages {
  var cubit = Modular.get<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cubit.onInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileState>(
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
            return BaseScaffold(
              title: 'Profile',
              children: state.status == Status.loading
                  ? []
                  : [
                      const SizedBox(height: 10),
                      UserPictureAndNameWidget(
                        name: state.name ?? 'Fulano',
                        picture: state.picture ?? 'https://xsgames.co/randomusers/avatar.php?g=male', // https://xsgames.co/randomusers/avatar.php?g=male
                        onTap: () {},
                      ),
                      //
                      //
                      const SizedBox(height: kMarginBig),
                      GenericProfileElement(
                        title: 'Dados pessoais',
                        subTitle: 'Foto, e-mail e telefone',
                        icon: LineIcons.user,
                        onTap: () async {
                          var newUserData = await cubit.onPressEdit();

                          print('... NEW USER: $newUserData ');

                          if(newUserData != null){
                            cubit.updateUserData(newUserData);
                            // scenario that user changed info and this screen should be updated
                          }
                        }, //cubit.onUserInfoClick
                      ),

                      //
                      //
                      const SizedBox(height: kMarginBig),
                      NotificationElement(
                        isAvailable: state.allowNotification,
                        onChange: (value) {
                          cubit.onUpdateAllowNotification(value);
                        },
                        icon: LineIcons.bellAlt,
                        title: 'Notificações',
                        subTitleOn: 'Permitir',
                        subTitleOff: 'Não Permitir',
                      ),
                      //
                      //
                      const SizedBox(height: kMarginBig),
                      const DarkModeToggleProfileWidget(),
                      //
                      //
                      const SizedBox(height: kMarginBig),
                      GenericProfileElement(
                        title: 'Permissões',
                        subTitle: 'Ajustar permissões ',
                        icon: LineIcons.userLock,
                        onTap: () {}, //  cubit.onPermissionReview
                      ),
                      //
                      //
                      const SizedBox(height: kMarginBig),
                      GenericProfileElement(
                        title: 'Política',
                        subTitle: 'Privacidade e termos de uso',
                        icon: LineIcons.bookReader,
                        onTap: () {},
                      ),
                      //
                      //
                      const SizedBox(height: kMarginBig),
                      GenericProfileElement(
                        title: 'Sair da conta',
                        subTitle: 'Acessar com outra conta',
                        icon: LineIcons.clone,
                        onTap: cubit.onPressLogout, //     cubit.onLogout,
                      ),
                      //
                      //
                      const SizedBox(height: kMarginBig),
                      GenericProfileElement(
                        title: 'Versão do Aplicativo',
                        subTitle: state.appVersion ?? '...',
                        icon: LineIcons.starOfLife,
                        // onTap: null, //     cubit.onLogout,
                      ),
                      const SizedBox(height: kMarginBig),
                    ],
            );
          }),
    );
  }
}
