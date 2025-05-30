
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';

class UserNameTextField extends StatelessWidget {
  const UserNameTextField({super.key, this.onEditingComplete, this.keyboardType, this.controller, this.initialValue, this.hintText, this.prefixIcon, this.focusNode});
  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final Widget? prefixIcon;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kDark,
      textInputAction: TextInputAction.next,
      onEditingComplete: onEditingComplete,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      initialValue: initialValue,
      controller: controller,
      focusNode:focusNode ,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
      style: appStyle(12, kGray, FontWeight.normal),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon:  prefixIcon,
        isDense: true,
        contentPadding: EdgeInsets.all(6.h),
        hintStyle: appStyle(12, kGray, FontWeight.normal),
        enabledBorder:  OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimary, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimary, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kRed, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kGray, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kRed, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimary, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),

      ),
    );
  }
}
