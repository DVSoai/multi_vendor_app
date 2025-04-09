import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_vendor_app/common/password_text_field.dart';
import 'package:multi_vendor_app/common/user_name_text_field.dart';
import 'package:multi_vendor_app/pages/auth/login/login_page.dart';
import 'package:multi_vendor_app/pages/auth/register/bloc/register_bloc.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';

import '../../../common/app_loader.dart';
import '../../../common/app_style.dart';
import '../../../common/back_ground_container.dart';
import '../../../common/custom_button.dart';
import '../../../common/email_text_field.dart';
import '../../../common/reusable_text.dart';
import '../../../core/constants/constants.dart';
import '../../../data/models/auth/register_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  late final TextEditingController _usernameController =
      TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  final _registerKey = GlobalKey<FormState>();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _usernameController.dispose();
    _usernameFocus.dispose();
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
      body: BlocListener<RegisterBloc,RegisterState>(
        listener: (context,state){
          if(state.isRegisterLoading == true){
            AppLoader.show(context);
          }else{
            AppLoader.hide();
          }
          if(state.isRegisterSuccess == true){
            context.go(RouterName.loginPage);
          } else if(state.isFailure == true){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
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
                      Gap(30.h),
                      Lottie.asset("assets/anime/delivery.json"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _registerKey,
                          child: Column(
                            children: [
                              UserNameTextField(
                                controller: _usernameController,
                                focusNode: _usernameFocus,
                                hintText: 'Username',
                                prefixIcon: const Icon(CupertinoIcons.person,
                                    size: 24, color: kGrayLight),
                              ),
                              Gap(25.h),
                              EmailTextField(
                                controller: _emailController,
                                focusNode: _emailFocus,
                                hintText: 'Email',
                                validator: (value){
                                  if(value!.isEmpty) {
                                    return 'Email is required';
                                  }
                                  else if(!emailRegex.hasMatch(value)){
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                                prefixIcon: const Icon(CupertinoIcons.mail,
                                    size: 24, color: kGrayLight),
                              ),
                              Gap(25.h),
                              PasswordTextField(
                                controller: _passwordController,
                                focusNode: _passwordFocus,
                                isPassword: true,
                                showPassword: state.isShowPassword,
                                toggleShowPassword: () =>
                                    context.read<RegisterBloc>().add(
                                        const ToggleShowPasswordRegister()),
                              ),
                              Gap(25.h),
                              CustomButton(
                                text: "R E G I S T E R",
                                onPressed: () {
                                  if(_registerKey.currentState!.validate()){
                                    context.read<RegisterBloc>().add(RegisterUser(
                                        registerModel:  RegisterModel(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            username: _usernameController.text
                                        ),
                                    ));
                                  }

                                },
                                btnWidth: width,
                                btnHeight: 35.h,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
