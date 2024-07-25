import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void unFocus(BuildContext context) => FocusScope.of(context).unfocus();

extension UnFocusExtension on BuildContext {
  void unfocus() => FocusScope.of(this).unfocus();
}

Future dismissKeyboard() {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  return Future.delayed(const Duration(milliseconds: 100));
}

///Tries to open the Whatsapp App.
///If it is not possible to open the app, the whatsapp on the browse will be open.
///Obs: In order to make it possible to open the App in iOS,
///it is necessary to edit Info.plist adding the following:
///<key>LSApplicationQueriesSchemes</key>
///         <array>
///             <string>whatsapp</string>
///         </array>
void openWhatsapp({required String phone, String? message = ''}) async {
  final appUrl = Uri.encodeFull('whatsapp://send?phone=$phone&text=$message');
  final webUrl = Uri.encodeFull('https://api.whatsapp.com/send?phone=$phone&text=$message');
  if (await launchUrl(Uri.parse(appUrl))) {
    await launchUrl(Uri.parse(appUrl));
  } else {
    await launchUrl(Uri.parse(webUrl));
  }
}

void openUrl({required String url}) async {
  if (await launchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    await launchUrl(Uri.parse(url));
  }
}
