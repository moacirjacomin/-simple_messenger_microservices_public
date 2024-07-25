import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            LineIcons.grimacingFace,
            size: 40,
            color: Colors.grey[400],
          ),
          Text('No friends'),
        ],
      ),
    );
  }
}
