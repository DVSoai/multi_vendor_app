import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    this.onEditingComplete,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.toggleShowPassword,
    this.isPassword = false,
    this.showPassword = false,
  });

  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function()? toggleShowPassword;
  final bool isPassword;
  final bool showPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kDark,
      textInputAction: TextInputAction.next,
      onEditingComplete: onEditingComplete,
      obscureText: showPassword,
      keyboardType: TextInputType.visiblePassword,
      controller: controller,
      focusNode: focusNode,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter valid Password';
        }
        if(value.length < 8){
          return 'Password > 8 ky tu';
        }
        return null;
      },
      style: appStyle(12, kGray, FontWeight.normal),
      decoration: InputDecoration(
        hintText: "Password",
        prefixIcon: const Icon(
          CupertinoIcons.lock_circle,
          size: 26,
          color: kGrayLight,
        ),
        suffixIcon: isPassword ? IconButton(
          onPressed: toggleShowPassword,
          icon: Icon(
            showPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
            color: kGrayLight,
            size: 26,
          ),
        ) : null,
        isDense: true,
        contentPadding: EdgeInsets.all(6.h),
        hintStyle: appStyle(12, kGray, FontWeight.normal),
        enabledBorder: OutlineInputBorder(
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
