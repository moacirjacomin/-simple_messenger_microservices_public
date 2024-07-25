import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/core_dimens.dart';

class UserAvatarWidget extends StatelessWidget {
  final String picture;
  final double size;
  final VoidCallback onTap;

  const UserAvatarWidget({
    Key? key,
    required this.picture,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final proportionalSize = CoreDimens.proportionalWidth(context, size);
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: proportionalSize,
        backgroundColor: AppColors.primary,
        child: CircleAvatar(
          radius: proportionalSize - kBorderWidthBig,
          onBackgroundImageError: (_, __) => SvgPicture.asset('assets/vector/my_profile_placeholder.svg'),
          backgroundImage: CachedNetworkImageProvider(picture),
        ),
      ),
    );
  }
}
