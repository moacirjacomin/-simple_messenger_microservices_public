import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../_shared/constants/core_dimens.dart';
import '../../../_shared/constants/status.dart';
import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/presentation/mixins/loader_mixin.dart';
import '../../../_shared/presentation/mixins/message_mixin.dart';
import '../../../_shared/presentation/widgets/base_button.dart';
import '../../../_shared/presentation/widgets/base_text_field.dart';
import '../../../_shared/presentation/widgets/field_types.dart';
import '../../profile_module.dart';
import '../cubit/user_edit_cubit.dart';
import '../widgets/avatar_edit_simple_widget.dart';

class UserEditPage extends StatefulWidget {
  static const routeName = '/user_edit';
  static const routePath = '${ProfileModule.moduleName}$routeName';

  const UserEditPage({super.key});

  @override
  State<UserEditPage> createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> with Loader, Messages {
  late UserEditCubit cubit;
  late CurrentUser userData;

  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cubit = Modular.get<UserEditCubit>();

    userData = Modular.args.data as CurrentUser;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nameEC.text = userData.name;
      emailEC.text = userData.email;
      cubit.onInit(userData);
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameEC.dispose();
    emailEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar Meus Dados'),
      ),
      body: BlocConsumer<UserEditCubit, UserEditState>(
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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kMarginDefault,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: kMarginBig),
                    AvatarEditSimpleWidget(
                      picture: state.picture ?? userData.avatar,
                      onSelectSource: cubit.onImageSourceSelected,
                      isLoading: state.status == Status.loading,
                    ),
                    //
                    //
                    const SizedBox(height: kMarginBig),
                    BaseTextField(
                      TextFieldType.name,
                      controller: nameEC,
                      isEnabled: true,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      // autoValidateMode: AutovalidateMode.onUserInteraction,
                      // onChanged: cubit.onEmailChange,
                      hint: 'Nome',
                      // text: state.name ?? userData.name,
                      borderType: BorderType.outline,
                      // isReadOnly: !cubit.isCustomer,
                      validator: Validatorless.required('Nome eh obrigatorio'),
                    ),
                    //
                    //
                    const SizedBox(height: kMarginBig),
                    BaseTextField(
                      TextFieldType.email,
                      controller: emailEC,
                      isEnabled: true,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      // autoValidateMode: AutovalidateMode.onUserInteraction,
                      // onChanged: cubit.onEmailChange,
                      hint: 'Email',
                      borderType: BorderType.outline,
                      // isReadOnly: !cubit.isCustomer,
                      validator: Validatorless.multiple([
                        Validatorless.required('E-mail is mandatory'),
                        Validatorless.email('Invalid e-mail format'),
                      ]),
                    ),
                    //
                    //
                    const SizedBox(
                       height: 50,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kMarginDefault,
          vertical: 4,
        ),
        child: BaseButton(
          text: 'Salvar',
          // isLoading: state.status == Status.loading,
          width: double.infinity,
          onClick: () {
            var isFormValid = formKey.currentState?.validate() ?? false;

            if (isFormValid) {
              cubit.onSave(
                email: emailEC.text,
                name: nameEC.text,
                context: context
              );
            } else {
              showError('Hum, parece haver algo errado com os dados');
            }
          },
        ),
      ),
    );
  }
}
