import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 35.h,
                      width: 35.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset('assets/images/user.jpg',fit: BoxFit.cover,),
                      ),
                    ),
                    Gap(10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('UserName',style: appStyle(13, kDark, FontWeight.w400),),
                        Text('MarshalDev@gmail.com',style: appStyle(11, kGray, FontWeight.w400),),
                      ],

                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
