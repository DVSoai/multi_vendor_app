import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/pages/auth/login/login_page.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';

import '../../../common/back_ground_container.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_container.dart';

class LoginRedirect extends StatefulWidget {
  const LoginRedirect({super.key});

  @override
  State<LoginRedirect> createState() => _LoginRedirectState();
}

class _LoginRedirectState extends State<LoginRedirect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: kLightWhite,
        title: const Text('Please login to access this page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
           context.pop();
          },
        ),
      ),
      body: CustomContainer(
        color: Colors.white,
        containerContent: Column(
          children: [
            Gap(100.h),
            Lottie.asset("assets/anime/delivery.json"),
            Gap(50.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child:  CustomButton(
                text: "L O G I N",
                onPressed: (){
                  context.push(RouterName.loginPage);
                },
                btnWidth: width,
                btnHeight: 40.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}
