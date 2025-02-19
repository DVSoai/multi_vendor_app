import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/routers/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child){
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Multi Vendor App',
          routerDelegate: AppRouters.router.routerDelegate,
          theme: ThemeData(
            scaffoldBackgroundColor: kOffWhite,
            iconTheme: const IconThemeData(color: kDark),
            primarySwatch: Colors.grey
          ),
          routeInformationParser:
          AppRouters.router.routeInformationParser,
          routeInformationProvider:
          AppRouters.router.routeInformationProvider,
        );
      },

    );
  }
}

