import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';

import '../../core/di/locator.dart';
import '../../core/network/local/global_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 1), () {
      context.go(RouterName.mainPage);

      // final storage = sl<GlobalStorage>();
      // debugPrint("user token db${storage.userToken}");
      // debugPrint("isLogin: ${storage.isLoggedIn}");
      // if (storage.userToken != null && storage.isLoggedIn == true) {
      //   context.go(RouterName.mainPage);
      // } else {
      //   context.go(RouterName.loginPage);
      // }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          width: width,
          height: height,
          'assets/images/splash1.png',
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
