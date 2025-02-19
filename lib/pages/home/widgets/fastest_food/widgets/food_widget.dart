import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/app_style.dart';
import '../../../../../common/reusable_text.dart';
import '../../../../../core/constants/constants.dart';

class FoodWidget extends StatelessWidget {
  const FoodWidget({super.key, required this.image, required this.title, required this.time, required this.price, this.onTap});
  final String image;
  final String title;
  final String time;
  final double price;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
            width: width * .75,
            height: 192.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: kLightWhite,
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: SizedBox(
                          height: 112.h,
                          width: width * 0.8,
                          child: Image.asset(
                            image,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                              text: title,
                              style: appStyle(14, kDark, FontWeight.w500)),
                          ReusableText(text:' \$$price', style: appStyle(13, kPrimary, FontWeight.w500))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                              text: 'Delivery time',
                              style: appStyle(11, kGray, FontWeight.w500)),
                          ReusableText(
                              text: time,
                              style: appStyle(11, kDark, FontWeight.w500))
                        ],
                      ),
                      
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
