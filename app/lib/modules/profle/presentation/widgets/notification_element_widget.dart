import 'package:flutter/material.dart';

class NotificationElement extends StatelessWidget {
  final Function(bool) onChange;
  final bool isAvailable;
  final String title;
  final String subTitleOn;
  final String subTitleOff;
  final IconData icon;
  final double? iconSize;

  const NotificationElement({
    Key? key,
    required this.onChange,
    required this.isAvailable,
    required this.title,
    required this.subTitleOn,
    required this.subTitleOff,
    required this.icon,
    this.iconSize = 30,
  }) : super(key: key);

  Widget iconElement(IconData iconData, BuildContext context) {
    return Container(
      height: 65,
      width: 65,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        // color: Colors.grey[200],
        color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(15),
      ),
      child: Icon(iconData, size: iconSize, color: Theme.of(context).textTheme.bodyLarge?.color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(16, 7, 0, 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconElement(icon, context),
          Expanded(
            child: SwitchListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      // color: Colors.black54,
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(150),
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isAvailable == true ? subTitleOn : subTitleOff,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: isAvailable == true ? Colors.green : Colors.red,
                        fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
                  )
                ],
              ),
              value: isAvailable,
              onChanged: onChange,
              activeColor: Colors.green,
              inactiveTrackColor: Colors.red.withAlpha(200),
            ),

            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       title,
            //       style: TextStyle(
            //         fontWeight: FontWeight.w500,
            //         color: Colors.black54,
            //         fontSize: Theme.of(context).textTheme.bodyText1!.fontSize
            //       ),
            //     ),
            //     const SizedBox(height: 4),
            //     Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Expanded(
            //           child: Text(
            //             isAvailable == true ? subTitleOn : subTitleOff,
            //             maxLines: 2,
            //             style: TextStyle(
            //               fontWeight: FontWeight.w400,
            //               color: Colors.black45,
            //               fontSize: Theme.of(context).textTheme.bodyText1!.fontSize
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ),
        ],
      ),
    );

    // return SwitchListTile(
    //   title: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         'Disponibilidade',
    //         style: Theme.of(context).textTheme.subtitle2?.copyWith(
    //               fontWeight: FontWeight.w300,
    //               color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(1),
    //             ),
    //       ),
    //       const SizedBox(height: 2),
    //       isAvailable == true ? Text('Disponível', style: TextStyle(color: Colors.green)) : Text('Indisponível', style: TextStyle(color: Colors.red)),
    //     ],
    //   ),
    //   value: isAvailable,
    //   onChanged: onChange,
    //   activeColor: Colors.green,
    //   inactiveTrackColor: Colors.red.withAlpha(200),
    // );
  }
}
