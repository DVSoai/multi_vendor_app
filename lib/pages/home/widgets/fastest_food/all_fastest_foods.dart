import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/pages/home/widgets/fastest_food/bloc/food_bloc.dart';
import 'package:multi_vendor_app/pages/home/widgets/fastest_food/widgets/food_title.dart';

import '../../../../common/app_loader.dart';
import '../../../../common/app_style.dart';
import '../../../../common/back_ground_container.dart';
import '../../../../common/reusable_text.dart';
import '../../../../core/shimmers/foodlist_shimmer.dart';
import '../../../cart/bloc/cart_bloc.dart';

class AllFastestFoods extends StatelessWidget {
  const AllFastestFoods({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc,CartState>(
      listener: (context, state) {
        if (state.status == CartStatus.loading) {
          AppLoader.show(context);
        } else {
          AppLoader.hide();
        }

        if (state.status == CartStatus.success && state.action == CartAction.add) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: ReusableText(
                  text: "Added to cart",
                  style: appStyle(12, kLightWhite, FontWeight.w400)),
              backgroundColor: kPrimary,
            ),
          );
        } else if (state.status == CartStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: ReusableText(
                  text: state.errorMessage ?? "Error",
                  style: appStyle(12, kLightWhite, FontWeight.w400)),
              backgroundColor: kPrimary,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ReusableText(
              text: 'Fastest Foods',
              style: appStyle(13, kOffWhite, FontWeight.w600)),
          elevation: 0.3,
          backgroundColor: kSecondary,
        ),
        body: BackGroundContainer(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: BlocBuilder<FoodBloc, FoodState>(
                builder: (context,state) {
                  var foods = state.foods;
                  if (state.isLoading == true) {
                    return const FoodsListShimmer();
                  } else {
                    return ListView.builder(
                        itemCount: foods.length,
                        itemBuilder: (context, index) {
                          var food = foods[index];
                          return FoodTitle(food: food);
                        }
                    );
                  }
                }
            ),
          ),
        ),
      ),
    );
  }
}
