import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/core/constants/uidata.dart';
import 'package:multi_vendor_app/core/shimmers/foodlist_shimmer.dart';
import 'package:multi_vendor_app/core/shimmers/nearby_shimmer.dart';
import 'package:multi_vendor_app/pages/categories/all_categories.dart';
import 'package:multi_vendor_app/pages/home/bloc/home_bloc.dart';
import 'package:multi_vendor_app/pages/home/widgets/nearby_restaurant/widgets/restaurant_widget.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';

class NearbyRestaurantsList extends StatelessWidget {
  const NearbyRestaurantsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 194.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: BlocBuilder<HomeBloc, HomeState>(
          builder:(context,state){

            if(state.isLoading == true){
              return const NearbyShimmer();
            }else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.listRestaurant.length,
                itemBuilder: (context,index){
                  var restaurant = state.listRestaurant[index];
                  return RestaurantWidget(
                    onTap: (){
                      context.push(RouterName.restaurantPage,extra: restaurant);
                    },
                    image: restaurant.imageUrl,
                    logo: restaurant.logoUrl,
                    title: restaurant.title,
                    time: restaurant.time,
                    rating: restaurant.ratingCount,
                  );
                },
              );
            }
          }
      ),
    );
  }
}
