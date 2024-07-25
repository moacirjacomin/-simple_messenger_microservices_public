import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static AppStyles? _instance;
  AppStyles._();
  static AppStyles get instance => _instance ??= AppStyles._();

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      backgroundColor: AppColors.primary);
}

extension AppStylesExtension on BuildContext {
  AppStyles get appStyles => AppStyles.instance;
}

class TextStyles {
  static TextStyles? _instance;
  TextStyles._();
  static TextStyles get instance => _instance ??= TextStyles._();

  String get fontFamily => 'mplus1';

  TextStyle get light => TextStyle(fontWeight: FontWeight.w300, fontFamily: fontFamily);

  TextStyle get regular => TextStyle(fontWeight: FontWeight.normal, fontFamily: fontFamily);

  TextStyle get medium => TextStyle(fontWeight: FontWeight.w500, fontFamily: fontFamily);

  TextStyle get semiBold => TextStyle(fontWeight: FontWeight.w600, fontFamily: fontFamily);

  TextStyle get bold => TextStyle(fontWeight: FontWeight.bold, fontFamily: fontFamily);

  TextStyle get extraBold => TextStyle(fontWeight: FontWeight.w800, fontFamily: fontFamily);

  TextStyle get textButtonLabel => extraBold.copyWith(fontSize: 14);

  TextStyle get textTitle => extraBold.copyWith(fontSize: 22);
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}

class ThemeConfig {
  ThemeConfig._();

  static ThemeData selector(bool isDarkmode, BuildContext context) {
    var contrastColor = isDarkmode ? Colors.white : Colors.black;
    return ThemeData(
      brightness: isDarkmode ? Brightness.dark : Brightness.light,
      fontFamily: 'Poppins',
      useMaterial3: false,
      // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.secondary), // .copyWith(background: Colors.white),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        // color: Theme.of(context).canvasColor,
        color: Colors.transparent,
        iconTheme: IconThemeData(color: contrastColor),
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: contrastColor,
              // color: Colors.red,
              fontWeight: FontWeight.w700,
              fontSize: 27,
            ),
        toolbarTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: contrastColor,
              // color: Colors.red,
              fontWeight: FontWeight.w700,
              fontSize: 27,
            ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(64.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          foregroundColor: Colors.black,
          backgroundColor: AppColors.primary,
        ),
      ),
      // outlinedButtonTheme: OutlinedButtonThemeData(
      //   style: OutlinedButton.styleFrom(
      //     minimumSize: Size.fromHeight(64.0),
      //     shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
      //     ),
      //   ).copyWith(
      //     foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      //     backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      //     side: MaterialStateProperty.all<BorderSide>(
      //       BorderSide(color: AppColors.secondary, width: 1.0),
      //     ),
      //   ),
      // ),
    );
  }

 
}
