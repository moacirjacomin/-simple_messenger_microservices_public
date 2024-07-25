import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'widgets/menu_bottom_widget.dart';

class LayoutShared extends StatelessWidget {
  final Widget body;
  const LayoutShared({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body, 
      bottomNavigationBar: MenuBottomWidget(
        items: [
          MenuItem(label: context.tr('menu-chat'), icon: LineIcons.commentsAlt, navigateTo: '/home/chat'),
          MenuItem(label: context.tr('menu-call'), icon: LineIcons.video, navigateTo: '/home/call'),
          MenuItem(label: context.tr('menu-people'), icon: LineIcons.users, navigateTo: '/home/people'),
          MenuItem(label: context.tr('menu-stories'), icon: LineIcons.tags, navigateTo: '/home/stories'),
          MenuItem(label: context.tr('menu-profile'), icon: LineIcons.identificationBadgeAlt, navigateTo: '/home/profile/'),
          // MenuItem(label: 'Debug', icon: LineIcons.dragon, onTap: cubit.DEBUG_onUserInfo),
        ],
      ),
    );
  }
}
