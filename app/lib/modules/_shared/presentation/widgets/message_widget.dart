import 'package:flutter/material.dart';

import '../../../home/data/models/message_model.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel message;
  final int friendId;
  final bool isDarkMode;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.friendId,
    this.isDarkMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double textWidth = MediaQuery.of(context).size.width * 0.8;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 4),
      child: Row(
        mainAxisAlignment: message.creatorId == friendId ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          SizedBox(
            // width: textWidth,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: textWidth,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
                decoration: BoxDecoration(
                  color: message.creatorId == friendId ? AppColors.buttonDisabled.withOpacity(isDarkMode ? 0.1 : 0.5) : AppColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  message.message,
                  style: context.textStyles.regular.copyWith(height: 1.4, color: message.creatorId == friendId ? null : Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
