import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key, required this.username, required this.email, required this.image});

  final String username,email,image;

  @override
  Widget build(BuildContext context) {
    debugPrint('user image $image');
    debugPrint('username $username');
    debugPrint('email $email');

    return Container(
      height: height * 0.06,
      width: width,
      color: kLightWhite,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 0, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 35.h,
                      width: 35.w,
                      child: CircleAvatar(
                        backgroundColor: kGrayLight,
                        backgroundImage: NetworkImage(
                          image
                        ),
                      ),
                    ),
                    Gap(10.w),
                    Padding(
                      padding:  EdgeInsets.all(4.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         ReusableText(text: username, style: appStyle(12, kGray, FontWeight.w600)),
                          ReusableText(text: email, style: appStyle(10, kGray, FontWeight.normal))
                        ],

                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:  EdgeInsets.all(4.h),
                  child: GestureDetector(
                    onTap: (){
                    },
                    child: SvgPicture.asset('assets/icons/edit.svg',width: 20.w,height: 20.h,),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
