import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/back_ground_container.dart';
import 'package:multi_vendor_app/common/custom_button.dart';
import 'package:multi_vendor_app/common/email_text_field.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimary,
        title: Center(
          child: ReusableText(
              text: 'Foodly Family',
              style: appStyle(20, kLightWhite, FontWeight.bold)),
        ),
      ),
      body: BackGroundContainer(
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Gap(30.h), Lottie.asset("assets/anime/delivery.json"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20),
                child: Column(
                  children: [
                    EmailTextField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      hintText: 'Email',
                      prefixIcon: const Icon(CupertinoIcons.mail,size: 24,color: kGrayLight),
                    ),
                    Gap(25.h),
                    EmailTextField(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      hintText: 'Password',
                      prefixIcon: const Icon(CupertinoIcons.lock,size: 24,color: kGrayLight),
                    ),
                    Padding(padding:const EdgeInsets.only(top: 8),child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                          },
                          child: ReusableText(text: 'Forgot Password?',style: appStyle(12, kPrimary, FontWeight.w400),),
                        )
                      ],
                    ),),
                    Gap(25.h),
                    CustomButton(
                      text: "L O G I N",
                      onPressed: (){},
                      btnWidth: width,
                      btnHeight: 35.h,
                    ),
                    Gap(25.h),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
