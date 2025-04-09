import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_vendor_app/common/app_loader.dart';
import 'package:multi_vendor_app/common/password_text_field.dart';
import 'package:multi_vendor_app/pages/auth/bloc/login_bloc.dart';
import 'package:multi_vendor_app/pages/auth/login/email_verification/email_verification.dart';
import 'package:multi_vendor_app/pages/auth/phone_verification/phone_verification_page.dart';
import 'package:multi_vendor_app/pages/categories/all_categories.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';

import '../../../common/app_style.dart';
import '../../../common/back_ground_container.dart';
import '../../../common/custom_button.dart';
import '../../../common/email_text_field.dart';
import '../../../common/reusable_text.dart';
import '../../../core/constants/constants.dart';
import '../../../core/di/locator.dart';
import '../../../core/network/local/global_storage.dart';
import '../../../data/models/auth/login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

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
      body: BlocListener<LoginBloc, LoginState>(
        listener:(context,state) {
          if(state.isLoginLoading == true){
            AppLoader.show(context);
          }else{
            AppLoader.hide();
          }
          if(state.isLoginSuccess == true){
            final user  = sl<GlobalStorage>().user;
           if(user!.verification == false){
            context.push(RouterName.emailVerification);
           }else {
             context.go(RouterName.mainPage);
           }
           debugPrint('Login Success');
           debugPrint('user: ${sl<GlobalStorage>().userToken}');
          }else if(state.isFailure == true){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: ReusableText(text: state.message!,
                style: appStyle(14, kLightWhite, FontWeight.w400),),
              backgroundColor: kRed,
            ));
          }
        },

          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context,state){
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
                        child: Form(
                          key: _loginKey,
                          child: Column(
                            children: [
                              EmailTextField(
                                controller: _emailController,
                                focusNode: _emailFocus,
                                hintText: 'Email',
                                prefixIcon: const Icon(
                                    CupertinoIcons.mail, size: 24,
                                    color: kGrayLight),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email is required';
                                  } else if (!emailRegex.hasMatch(value)) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
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
                                onPressed: () {
                                  if (_loginKey.currentState!.validate()) {
                                    context.read<LoginBloc>().add(LoginSubmitted(
                                       loginModel:  LoginModel(
                                            email: _emailController.text.trim(),
                                            password: _passwordController.text.trim())));
                                  }
                                },
                                btnWidth: width,
                                btnHeight: 35.h,
                              ),
                              Gap(25.h),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}
