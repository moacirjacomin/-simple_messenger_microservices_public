import 'package:flutter/material.dart';

class GenericProfileElement extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final VoidCallback? onTap;
  final double? iconSize;
  const GenericProfileElement({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.onTap,
    this.iconSize = 30,
  }) : super(key: key);

  Widget iconElement(IconData iconData, BuildContext context) {
    return Container(
      height: 65,
      width: 65,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(15),
      ),
      child: Icon(iconData, size: iconSize, color: Theme.of(context).textTheme.bodyLarge?.color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(16, 7, 16, 1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconElement(icon, context),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      // color: Colors.black54,
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(150),
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          subTitle,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            // color: Colors.black45,
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(110),
                            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Spacer(),
            if(onTap != null)
            const Icon(
              Icons.chevron_right_outlined,
              color: Colors.grey,
            ),
            // Icon(Icons.chevron_right_rounded, color: Colors.grey,),
          ],
        ),
      ),
    );
  }
}