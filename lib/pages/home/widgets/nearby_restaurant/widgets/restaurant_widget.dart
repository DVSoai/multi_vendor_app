import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/back_ground_container.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';

class RestaurantWidget extends StatelessWidget {
  const RestaurantWidget(
      {super.key,
      required this.image,
      required this.logo,
      required this.title,
      required this.time,
      required this.rating,
      this.onTap});

  final String image;
  final String logo;
  final String title;
  final String time;
  final String rating;
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
                          child: Image.network(
                            image,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 4.w,
                        top: 4.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.r),
                          child: Container(
                            color: kLightWhite,
                            child: Padding(
                              padding: EdgeInsets.all(2.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: Image.network(
                                  logo,
                                  height: 32.h,
                                  width: 32.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: title,
                          style: appStyle(14, kDark, FontWeight.w500)),
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
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: 5,
                            itemBuilder: (context, index) => const Icon(
                              CupertinoIcons.star_fill,
                              color: kPrimary,
                            ),
                            itemCount: 5,
                            itemSize: 15.h,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          ReusableText(
                              text: " + $rating reviews and ratings",
                              style: appStyle(11, kGray, FontWeight.w500))
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
