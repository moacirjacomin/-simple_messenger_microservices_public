import 'package:flutter/material.dart';


class BackgroundWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const BackgroundWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Image.asset(
        'assets/images/bg_custom.png',
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
