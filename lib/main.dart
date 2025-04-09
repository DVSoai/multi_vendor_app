import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/firebase_options.dart';
import 'package:multi_vendor_app/routers/app_router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/di/locator.dart';
import 'core/network/local/global_storage.dart';


ServiceLocator dependencyInjector = ServiceLocator();
Future<void>main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding:  WidgetsFlutterBinding.ensureInitialized());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  dependencyInjector.servicesLocator();
  await Hive.openBox(GlobalStorageKey.globalStorage);
  runApp(const MyApp());
  FlutterNativeSplash.remove();
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

