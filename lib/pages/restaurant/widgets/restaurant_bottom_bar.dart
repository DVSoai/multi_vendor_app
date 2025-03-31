import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/pages/restaurant/restaurant_page.dart';

import '../../../common/custom_button.dart';
import '../../../core/constants/constants.dart';
import '../../../data/models/hook_models/restaurant_model.dart';
import '../../../routers/routers_name.dart';

class RestaurantBottomBar extends StatelessWidget {
  const RestaurantBottomBar({
    super.key,
    required this.widget,
  });

final RestaurantPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
      height: 40.h,
      decoration: BoxDecoration(
          color: kPrimary.withOpacity(0.4),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              topLeft: Radius.circular(8.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RatingBarIndicator(
            itemCount: 5,
            itemBuilder: (context, i) =>
            const Icon(Icons.star, color: Colors.amber),
            rating: widget.restaurantModel!.rating.toDouble(),
            itemSize: 20.sp,
          ),
          CustomButton(
            onPressed: () {
              context.push(RouterName.ratingPage);
            },
            text: 'Rate Restaurant',
            btnColor: kSecondary,
            btnWidth: width/3,
          )
        ],
      ),
    );
  }
}