import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../_shared/constants/app_styles.dart';
import '../../../_shared/constants/core_dimens.dart';
import '../../../_shared/presentation/widgets/base_button.dart';

 

class UserIsOfflineWidget extends StatelessWidget {
  final VoidCallback onTapRetry;

  const UserIsOfflineWidget({
    Key? key,
    required this.onTapRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //
          //
          Expanded(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LineIcons.frowningFaceAlt, size: 30),
                      const SizedBox(width: 10),
                      Text('Ops...', style: context.textStyles.textTitle),
                    ],
                  ),
                  const SizedBox(
                     height: 15,
                  ),
                  Text('Nosso serviço  está \n indisponível no momento.\n\nTente novamente mais tarde.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      )),
                  const SizedBox(height: kMarginMedium),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: BaseButton(
              text: 'Tentar novamente',
              width: double.infinity,
              isEnabled: true,
              isLoading: false,
              onClick: onTapRetry,
            ),
          ),
          const SizedBox(height: 10),

          const SizedBox(height: 5),
        ],
      ),
    );
  }
}// isBackendOffline UserIsOfflineWidget
