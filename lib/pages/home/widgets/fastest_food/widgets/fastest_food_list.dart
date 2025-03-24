import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/core/shimmers/foodlist_shimmer.dart';
import 'package:multi_vendor_app/pages/home/bloc/home_bloc.dart';
import 'package:multi_vendor_app/pages/home/widgets/fastest_food/widgets/food_widget.dart';

import '../../../../../core/constants/uidata.dart';

class FastestFoodList extends StatelessWidget {
  const FastestFoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 194.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: BlocBuilder<HomeBloc,HomeState>(
          builder:(context,state){
            if(state.isLoading){
              return const FoodsListShimmer();
            }else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.listFoods!.length,
                itemBuilder: (context, index) {
                  var food = state.listFoods![index];
                  return FoodWidget(
                      image: food.imageUrl,
                      title: food.title,
                      time: food.time,
                      price: food.price);
                },
              );
            }
          }
      ),
    );
  }
}
