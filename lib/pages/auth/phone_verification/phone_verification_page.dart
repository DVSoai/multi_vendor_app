import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/phone_verification.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/pages/auth/phone_verification/bloc/phone_verification_bloc.dart';
import '../../../common/app_loader.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneVerificationBloc, PhoneVerificationState>(
      listener: (context, state) {
        if (state.isLoading) {
          AppLoader.show(context);
        } else {
          AppLoader.hide();
        }

        if (state.isSuccess) {
          // Điều hướng đến trang chính hoặc bất kỳ đâu sau khi xác thực thành công
          context.pop();

        } else if (state.isFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: PhoneVerification(
        isFirstPage: true,
        enableLogo: false,
        themeColor: Colors.blueAccent,
        backgroundColor: kLightWhite,
        initialPageText: 'Verify Phone Number',
        initialPageTextStyle: appStyle(20, kPrimary, FontWeight.bold),
        textColor: kDark,
        otpController: phoneController,
        onCompleted: (pin) {
          // Callback khi người dùng hoàn tất nhập OTP
          debugPrint('Completed: $pin');
        },
        onSend: (phoneNumber) {
          debugPrint('Phone number: $phoneNumber');
          context.read<PhoneVerificationBloc>().add(
            PhoneVerificationStarted(phoneNumber: phoneNumber),
          );
        },
        onVerification: (otp) {
          debugPrint('OTP entered: $otp');
          final verificationId = context.read<PhoneVerificationBloc>().state.verificationId;

          if (verificationId.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Không tìm thấy mã xác minh. Vui lòng gửi lại OTP."),
                backgroundColor: Colors.orange,
              ),
            );
            return;
          }

          context.read<PhoneVerificationBloc>().add(
            PhoneCodeEntered(
              verificationId: verificationId,
              smsCode: otp,
            ),
          );
        },
      ),
    );
  }
}
