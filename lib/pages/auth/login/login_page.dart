import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_vendor_app/common/password_text_field.dart';
import 'package:multi_vendor_app/pages/auth/bloc/login_bloc.dart';
import 'package:multi_vendor_app/pages/categories/all_categories.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';

import '../../../common/app_style.dart';
import '../../../common/back_ground_container.dart';
import '../../../common/custom_button.dart';
import '../../../common/email_text_field.dart';
import '../../../common/reusable_text.dart';
import '../../../core/constants/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        centerTitle: true,
        title: ReusableText(
            text: 'Foodly Family',
            style: appStyle(20, kLightWhite, FontWeight.bold)),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) =>
          previous.isShowPassword != current.isShowPassword,
          builder: (context, state) {
            return BackGroundContainer(
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r)),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Gap(30.h), Lottie.asset("assets/anime/delivery.json"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          EmailTextField(
                            controller: _emailController,
                            focusNode: _emailFocus,
                            hintText: 'Email',
                            prefixIcon: const Icon(
                                CupertinoIcons.mail, size: 24,
                                color: kGrayLight),
                          ),
                          Gap(25.h),
                          PasswordTextField(
                            controller: _passwordController,
                            focusNode: _passwordFocus,
                            isPassword: true,
                            showPassword: state.isShowPassword,
                            toggleShowPassword: () =>
                                context.read<LoginBloc>().add(
                                    const ToggleShowPasswordLogin())
                            ,
                          ),
                          Padding(padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.push(RouterName.registerPage);
                                  },
                                  child: ReusableText(text: 'Register',
                                    style: appStyle(
                                        12, kPrimary, FontWeight.w400),),
                                )
                              ],
                            ),),
                          Gap(25.h),
                          CustomButton(
                            text: "L O G I N",
                            onPressed: () {},
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
            );
          }),
    );
  }
}
