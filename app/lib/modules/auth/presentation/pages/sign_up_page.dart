import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../_shared/constants/core_dimens.dart';
import '../../../_shared/constants/status.dart';
import '../../../_shared/presentation/widgets/base_button.dart';
import '../../../_shared/presentation/widgets/base_text_field.dart';
import '../../../_shared/presentation/widgets/expanded_scroll_view.dart';
import '../../../_shared/presentation/widgets/field_types.dart';
import '../../../_shared/utils/notify_utils.dart';
import '../../auth_module.dart';
import '../cubit/sign_up_cubit.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/sign_up';
  static const routePath = '${AuthModule.moduleName}$routeName';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _fieldName;
  late TextEditingController _fieldEmail;
  late TextEditingController _fieldPassword;
  final formKey = GlobalKey<FormState>();

  var cubit = Modular.get<SignUpCubit>();

  @override
  void initState() {
    _fieldEmail = TextEditingController(text: kDebugMode ? 'roberto@teste.com' : '');
    _fieldPassword = TextEditingController();
    _fieldName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fieldEmail.dispose();
    _fieldPassword.dispose();
    _fieldName.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // const BackgroundWidget(),
          Column(
            children: [
              Expanded(
                child: ExpandedScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Spacer(),
                        Hero(
                          tag: 'AppAssets.svgLogo',
                          child: SvgPicture.asset(
                            // 'assets/vectors/logo_otto.svg',
                            'assets/vectors/Logo.svg',
                            width: MediaQuery.of(context).size.width * 0.6,
                          ),
                        ),
                        const Spacer(),
                        // BaseButton(
                        //   text: AppStrings.login.signUpBtn,
                        //   type: ButtonType.SECONDARY,
                        //   width: MediaQuery.of(context).size.width * 0.6,
                        //   onClick: cubit.canSignUp ? cubit.onSignUpClicked : notImplementedFeature,
                        // ),
                        //
                        //
                        const SizedBox(height: kMarginBig),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kMarginDefault,
                          ),
                          child: BaseTextField(
                            TextFieldType.name,
                            hint: 'Nome',
                            controller: _fieldName,
                            // onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          ),
                        ),
                        //
                        //
                        const SizedBox(height: kMarginDefault),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kMarginDefault,
                          ),
                          child: BaseTextField(
                            TextFieldType.email,
                            hint: 'E-mail',
                            controller: _fieldEmail,
                            // onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          ),
                        ),
                        //
                        //
                        const SizedBox(height: kMarginDefault),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kMarginDefault,
                          ),
                          child: BaseTextField(
                            TextFieldType.password,
                            controller: _fieldPassword,
                            hint: 'Senha',
                            // isOptional: !state.isCpfCheckedfalse,
                          ),
                        ),
                        //
                        //
                        const SizedBox(height: kMarginBig),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: cubit.onSignInClicked,
                              child: const Padding(
                                padding: EdgeInsets.all(kMarginDefault),
                                child: Text(
                                  'Opa, ja tenho uma conta',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: kMarginDefault),
                      ],
                    ),
                  ),
                ),
              ),
              BlocConsumer<SignUpCubit, SignUpState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state.status == Status.failure) {
                    showError(state.failure!.getMessage());
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kMarginDefault,
                      vertical: 4,
                    ),
                    child: BaseButton(
                      text: 'Cadastrar',
                      isLoading: state.status == Status.loading,
                      width: double.infinity,
                      onClick: () {
                        if (formKey.currentState?.validate() != true) {
                          return;
                        }
                        cubit.onSignUpClicked(
                          name: _fieldName.text,
                          email: _fieldEmail.text,
                          password: _fieldPassword.text,
                          type: 'client',
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
