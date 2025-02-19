import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/pages/home/widgets/recommendations/widgets/recommendation_title.dart';

import '../../../../common/back_ground_container.dart';
import '../../../../core/constants/uidata.dart';

class Recommendations extends StatelessWidget {
  const Recommendations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ReusableText(
            text: 'All Recommendation ',
            style: appStyle(13, kLightWhite, FontWeight.w600)),
        elevation: 0.3,
        backgroundColor: kSecondary,
      ),
      body: BackGroundContainer(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(12.h),
          child: ListView.builder(
              itemCount: foods.length,
              itemBuilder: (context, index) {
                var food = foods[index];
                return RecommendationTitle(food: food);
              }

          ),
        ),
      ),
    );
  }
}
