import 'package:fluttertoast/fluttertoast.dart';

void showError(String msg) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
    );


void notImplementedFeature() => Fluttertoast.showToast(
      msg: 'Funcionalidade não implementada',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );