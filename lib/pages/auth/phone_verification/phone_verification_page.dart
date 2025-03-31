import 'package:flutter/material.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/phone_verification.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  TextEditingController phoneController = TextEditingController();
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhoneVerification(
        isFirstPage: true,
        enableLogo: false,
        themeColor: Colors.blueAccent,
        backgroundColor: kLightWhite,
        initialPageText: 'Verify Phone Number',
        initialPageTextStyle: appStyle(20, kPrimary, FontWeight.bold),
        textColor: kDark,
        otpController: phoneController,
        onCompleted: (pin) {
          print('Completed: $pin');
        },
        onSend: (String value){
          print('phone number: $value');
        },
        onVerification: (String value){
          print('OTP: $value');
        }
    );
  }
}
