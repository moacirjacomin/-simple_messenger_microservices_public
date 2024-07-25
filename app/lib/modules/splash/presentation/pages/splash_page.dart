// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Modular.get<SplashController>().onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'AppAssets.svgLogo',
          child: GestureDetector(
            onTap: Modular.get<SplashController>().testNavigateHome,
            child: SvgPicture.asset(
              // 'assets/vectors/logo_otto.svg',
              'assets/vectors/Logo.svg',
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          ),
        ),
      ),
    );
  }
}
