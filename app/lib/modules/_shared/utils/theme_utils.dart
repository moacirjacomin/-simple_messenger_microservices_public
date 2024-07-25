import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

ThemeData themeAdapter(bool isDarkMode, BuildContext context) {
  print('Theme adaptar isDarkMode=${isDarkMode}');
  return ThemeData( 
    primarySwatch: AppColors.primary,
    // brightness: isDarkMode == true ? Brightness.dark : Brightness.light,
    fontFamily: 'Poppins',
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: const Color(0xFF333333),
          displayColor: const Color(0xFF333333),
          fontFamily: 'Poppins',
        ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Theme.of(context).canvasColor,
      iconTheme: const IconThemeData(color: Colors.black),
      toolbarTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(64.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
        foregroundColor: Colors.black,
        backgroundColor: AppColors.primary,
      ),
      // .copyWith(
      //   foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
      //     (states) {
      //       if (states.contains(MaterialState.disabled)) {
      //         return AppColors.buttonDisabled;
      //       }
      //       return AppColors.primary;
      //     },
      //   )
      //   ,
      // ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(64.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ).copyWith(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(color: AppColors.secondary, width: 1.0),
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors.primary).copyWith(error: AppColors.error),
  );
}
