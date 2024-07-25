import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../_shared/constants/app_colors.dart';

class MenuBottomWidget extends StatefulWidget {
  final List<MenuItem> items;
  final bool? isDarkMode;
  const MenuBottomWidget({
    Key? key,
    required this.items,
    this.isDarkMode = false,
  }) : super(key: key);

  @override
  State<MenuBottomWidget> createState() => _MenuBottomWidgetState();
}

class _MenuBottomWidgetState extends State<MenuBottomWidget> {
  late int indexSelected = 0;
  var menuBackground = Colors.grey.withAlpha(40);

  Widget item(MenuItem item) {
    var itemPosition = widget.items.indexOf(item);
    var itemIsSelected = indexSelected == itemPosition;

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      // color: Colors.white, // Button color
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        // splashColor: AppColors.primary.shade100, // Splash color
        onTap: () {
          if(indexSelected == itemPosition) return; 

          setState(() {
            indexSelected = itemPosition;

            print('... item.navigateTo=${item.navigateTo}');
            Modular.to.navigate(item.navigateTo);
          });
          
        },
        child: SizedBox(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(  
                width: 30,
                height: 3,
                color: itemIsSelected ?AppColors.primary : Colors.transparent,
              ),
              const SizedBox(
                 height: 2,
              ),
              if (item.iconSvg != null && item.iconSvg != '')
                SizedBox(
                  height: item.iconSize ?? 25,
                  width: item.iconSize ?? 25,
                  child: SvgPicture.asset(
                    item.iconSvg!,
                    colorFilter: ColorFilter.mode(itemIsSelected ? item.colorSelected! : item.colorNotSelected!, BlendMode.srcIn),
                  ),
                ),
              if (item.icon != null)
                Icon(
                  item.icon,
                  size: item.iconSize ?? 29,
                  // color: itemIsSelected ? item.colorSelected : item.colorNotSelected,
                ),
              const SizedBox(
                height: 3,
              ),
              Text(
                item.label,
                style: const TextStyle(fontSize: 12, 
                // color: itemIsSelected ? item.colorSelected : item.colorNotSelected,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: 75,
      decoration:   BoxDecoration(
        color: menuBackground,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.map((e) => item(e)).toList(),
      ),
    );
  }
}

class MenuItem {
  final String label;
  final IconData? icon;
  final String? iconSvg;
  final String navigateTo;
  final double? iconSize;
  final Color? colorSelected;
  final Color? colorNotSelected;
  MenuItem({
    required this.label,
    this.icon,
    this.iconSvg,
    required this.navigateTo,
    this.iconSize,
    this.colorSelected = Colors.black,
    this.colorNotSelected = Colors.grey,
  });
}
