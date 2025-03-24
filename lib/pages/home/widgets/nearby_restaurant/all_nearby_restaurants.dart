import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/common/back_ground_container.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/core/shimmers/foodlist_shimmer.dart';
import 'package:multi_vendor_app/pages/home/widgets/nearby_restaurant/bloc/restaurant_bloc.dart';
import 'package:multi_vendor_app/pages/home/widgets/nearby_restaurant/widgets/restaurant_title.dart';

import '../../../../common/app_style.dart';
import '../../../../common/reusable_text.dart';

class AllNearbyRestaurants extends StatelessWidget {
  const AllNearbyRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ReusableText(
            text: 'Nearby Restaurants',
            style: appStyle(13, kOffWhite, FontWeight.w600)),
        elevation: 0,
        backgroundColor: kSecondary,
      ),
      body: BackGroundContainer(
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.all(12.h),
            child: BlocBuilder<RestaurantBloc,RestaurantState>(
              builder: (context, state){
                var restaurants = state.listAllRestaurant;
                if(state.isLoading == true){
                  return const FoodsListShimmer();
                }else {
                 return ListView.builder(
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = restaurants[index];
                        return RestaurantTitle(restaurant: restaurant);
                      }
                  );
                }
              },
            ),
      ),
    )
    );
  }
}
