import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';

class Heading extends StatelessWidget {
  const Heading({super.key, required this.title, required this.onTap, this.more = true});

  final String title;
  final void Function() onTap;
  final bool more;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: ReusableText(
                text: title, style: appStyle(16, kDark, FontWeight.bold)),
          ),
        more ==true?  GestureDetector(
            onTap: onTap,
            child: Icon(
              AntDesign.appstore1,
              color: kSecondary,
              size: 20.sp,
            ),
          ) : const SizedBox.shrink()
        ],
      ),
    );
  }
}
