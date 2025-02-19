import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/core/constants/uidata.dart';
import 'package:multi_vendor_app/pages/home/widgets/nearby_restaurant/widgets/restaurant_widget.dart';

class NearbyRestaurantsList extends StatelessWidget {
  const NearbyRestaurantsList({super.key});

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
          return RestaurantWidget(
            image: restaurant['imageUrl'],
            logo: restaurant['logoUrl'],
            title: restaurant['title'],
            time: restaurant['time'],
            rating: restaurant['ratingCount'],
          );
        },
      ),
    );
  }
}
