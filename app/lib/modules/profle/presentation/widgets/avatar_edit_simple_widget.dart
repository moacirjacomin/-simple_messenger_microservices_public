import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../_shared/constants/app_colors.dart';
import '../../../_shared/constants/core_dimens.dart';
import '../../../_shared/presentation/widgets/base_button.dart';

class AvatarEditSimpleWidget extends StatelessWidget {
  final String picture;
  final double size;
  final Function(String) onSelectSource;
  final bool? isLoading;

  const AvatarEditSimpleWidget({
    required this.picture,
    this.size = 70.0,
    required this.onSelectSource,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final proportionalSize = CoreDimens.proportionalWidth(context, size);
    return GestureDetector(
      onTap: () {
        if (isLoading == true) return;

        showModalBottomSheet(
          constraints: BoxConstraints(
            maxHeight: 310,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Text('Qual a fonte da foto?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 35),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: double.infinity, height: 50),
                      child: BaseButton(
                        text: 'Camera',
                        width: double.infinity,
                        isEnabled: true,
                        type: ButtonType.OUTLINED,
                        isLoading: false,
                        backgroundColor: Colors.transparent,
                        borderColor: AppColors.primary,
                        onClick: () {
                          Navigator.pop(context);
                          print('cliquei na CAMERA');
                          onSelectSource('camera');
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: double.infinity, height: 50),
                      child: BaseButton(
                        text: 'Galeria',
                        width: double.infinity,
                        isEnabled: true,
                        type: ButtonType.OUTLINED,
                        isLoading: false,
                        backgroundColor: Colors.transparent,
                        borderColor: AppColors.primary,
                        onClick: () {
                          print('cliquei na GALERIA');
                          Navigator.pop(context);
                          onSelectSource('gallery');
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Column(
        children: [
         Hero(
            tag: 'userAvatar',
            child: CircleAvatar(
              radius: proportionalSize,
              backgroundColor: AppColors.primary,
              child: CircleAvatar(
                radius: proportionalSize - kBorderWidthBig,
                onBackgroundImageError: (_, __) => SvgPicture.asset('assets/vectors/my_profile_placeholder.svg'),
                backgroundImage: CachedNetworkImageProvider(picture),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: isLoading == false
                ? Text(
                    'Alterar Foto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      // color: Colors.black87,
                      decoration: TextDecoration.underline,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Salvando, aguarde.. ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          // color: Colors.black54,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
