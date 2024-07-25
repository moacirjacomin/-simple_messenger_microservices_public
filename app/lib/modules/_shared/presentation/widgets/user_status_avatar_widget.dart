import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/core_dimens.dart';
import '../cubit/app_cubit.dart';

class UserStatusAvatarWidget extends StatefulWidget {
  final int userId;
  final String picture;
  final double size;
  final VoidCallback onTap;

  const UserStatusAvatarWidget({
    Key? key,
    required this.picture,
    required this.size,
    required this.onTap,
    required this.userId,
  }) : super(key: key);

  @override
  State<UserStatusAvatarWidget> createState() => _UserStatusAvatarWidgetState();
}

class _UserStatusAvatarWidgetState extends State<UserStatusAvatarWidget> {
  late AppCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = Modular.get<AppCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final proportionalSize = CoreDimens.proportionalWidth(context, widget.size);
    return BlocSelector<AppCubit, AppState, List<int>>(
        bloc: Modular.get<AppCubit>(),
        selector: (state) => state.activeFriends,
        builder: (context, activeFriends) {
          print('activeFriends=$activeFriends userId=${widget.userId} friendAvatar_${widget.userId}');
          return Stack(
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: Hero(
                  tag: 'friendAvatar_${widget.userId}',
                  child: CircleAvatar(
                    radius: proportionalSize,
                    backgroundColor: AppColors.primary,
                    child: CircleAvatar(
                      radius: proportionalSize - kBorderWidthBig,
                      onBackgroundImageError: (_, __) => SvgPicture.asset('assets/vector/my_profile_placeholder.svg'),
                      backgroundImage: CachedNetworkImageProvider(widget.picture),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 1,
                child: CircleAvatar(
                  radius: widget.size * 0.4,
                  backgroundColor: activeFriends.contains(widget.userId) ? Colors.green : Colors.red,
                ),
              ),
            ],
          );
        });
  }
}
