import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_vendor_app/common/app_loader.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/custom_button.dart';
import 'package:multi_vendor_app/common/custom_container.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/di/locator.dart';
import '../../../../data/repositories/auth/email_verification/email_verification_repository.dart';
import 'bloc/email_verification_bloc.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocListener<EmailVerificationBloc,EmailVerificationState>(
      listener: (context,state){
        if(state.isLoading == true){
          AppLoader.show(context);
        }else {
          AppLoader.hide();
        }
        if(state.isSuccess == true){
          context.go(RouterName.mainPage);

        } else if(state.isFailed == true){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Error'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },

      child: Scaffold(
        appBar: AppBar(
          title: ReusableText(
              text: "Please Verify Your Account ",
              style: appStyle(12, kGray, FontWeight.w600)),
          centerTitle: true,
          backgroundColor: kOffWhite,
          elevation: 0,
        ),
        body: CustomContainer(
          color: Colors.white,
          containerContent: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SizedBox(
              height: height,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Lottie.asset('assets/anime/delivery.json'),
                  Gap(30.h),
                  ReusableText(
                      text: 'Verify Your Account',
                      style: appStyle(20, kPrimary, FontWeight.w600)),
                  Gap(5.h),
                  Text(
                      "Enter the 6-digit code sent to your email, If you don't see the code, please check your spam folder",
                      style: appStyle(12, kGray, FontWeight.normal)),
                  Gap(20.h),
                  Pinput(
                    controller: otpController,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    readOnly: false,
                    length: 6,
                    defaultPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2.0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onChanged: (String code) {},
                    onCompleted: (pin) {
                      print('Completed: $pin');
                    },
                  ),
                  Gap(20.h),
                  CustomButton(
                    text: 'V E R I F Y   A C C O U N T',
                    onPressed: () {
                      context.read<EmailVerificationBloc>().add(
                        EmailVerificationCodeChanged(
                          otpController.text,
                        ),

                      );
                    },
                    btnHeight: 35.h,
                    btnWidth: width,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
