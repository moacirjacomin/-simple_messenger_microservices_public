import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../_shared/constants/app_colors.dart';
import '../../../_shared/constants/core_dimens.dart';

class UserPictureAndNameWidget extends StatelessWidget {
  final String picture;
  final double size;
  final String name;
  final VoidCallback onTap;

  const UserPictureAndNameWidget({
    super.key,
    required this.picture,
    // ignore: unused_element
    this.size = 70.0,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final proportionalSize = CoreDimens.proportionalWidth(context, size);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Hero(
            tag: 'userAvatar',
            child: CircleAvatar(
              radius: proportionalSize,
              backgroundColor: AppColors.primary,
              child: CircleAvatar(
                radius: proportionalSize - kBorderWidthBig,
                onBackgroundImageError: (_, __) => SvgPicture.asset('assets/vector/my_profile_placeholder.svg'),
                backgroundImage: CachedNetworkImageProvider(picture),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                // color: Colors.black87,
                fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              ),
            ),
          )
        ],
      ),
    );
  }
}
