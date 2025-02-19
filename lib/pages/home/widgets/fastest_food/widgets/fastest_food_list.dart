import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/pages/home/widgets/fastest_food/widgets/food_widget.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/uidata.dart';

class FastestFoodList extends StatelessWidget {
  const FastestFoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 194.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: foods.length,
        itemBuilder: (context, index) {
          var food = foods[index];
          return FoodWidget(
              image: food['imageUrl'],
              title: food['title'],
              time: food['time'],
              price: food['price']);
        },
      ),
    );
  }
}
