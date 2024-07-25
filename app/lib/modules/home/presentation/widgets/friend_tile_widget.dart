import 'package:flutter/material.dart';

import '../../../_shared/constants/app_styles.dart';
import '../../../_shared/presentation/widgets/user_status_avatar_widget.dart';
import '../../data/models/friend_model.dart';

class FriendTileWidget extends StatelessWidget {
  final FriendModel friend;
  final VoidCallback onTap;
  final double? avatarSize;

  const FriendTileWidget({
    Key? key,
    required this.friend,
    required this.onTap,
    this.avatarSize = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserStatusAvatarWidget(userId: friend.id, picture: friend.avatar, size: avatarSize!, onTap: onTap),
            const SizedBox(width: 15),
            Text(
              friend.name,
              style: context.textStyles.semiBold.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
