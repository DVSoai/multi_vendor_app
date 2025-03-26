import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onPressed, this.btnWidth, this.btnHeight, this.btnColor, required this.text,  this.radius = 9});

  final void Function()? onPressed;
  final double? btnWidth, btnHeight;
  final Color? btnColor;
  final String text;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: btnWidth ?? width,
        height: btnHeight ?? 36.h,
       decoration: BoxDecoration(
         color: btnColor ?? kPrimary,
          borderRadius: BorderRadius.circular(radius.r),
       ),
        child: Center(child: ReusableText(text: text, style: appStyle(14, kLightWhite, FontWeight.w500))),
      ),
    );
  }
}
