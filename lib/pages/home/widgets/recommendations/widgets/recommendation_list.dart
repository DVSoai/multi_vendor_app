import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/uidata.dart';

class RecommendationList extends StatelessWidget {
  const RecommendationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 194.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: restaurants.length,
        itemBuilder: (context,index){
          var restaurant = restaurants[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200.h,
              width: 150.w,
              color: kSecondary,
            ),
          );
        },
      ),
    );
  }
}
