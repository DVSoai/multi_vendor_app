
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_loader.dart';
import '../../../common/app_style.dart';
import '../../../common/reusable_text.dart';
import '../../../core/constants/constants.dart';
import '../../../core/shimmers/foodlist_shimmer.dart';
import '../../../data/models/hook_models/food_model.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../../home/widgets/fastest_food/widgets/food_title.dart';
import '../bloc/restaurant_page_bloc.dart';
class RestaurantExplore extends StatelessWidget {
  const RestaurantExplore({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    context.read<RestaurantPageBloc>().add(FetFoodExploreByCodeRestaurantPageEvent(code:code));
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
      child:  Scaffold(
          backgroundColor: kLightWhite,
          body: BlocBuilder<RestaurantPageBloc,RestaurantPageState>(
            builder: (context,state){
              if(state.isLoading == true){
                return const FoodsListShimmer();
              }else {
                return SizedBox(
                  height: height* 0.7,
                  child: ListView(
                    children: List.generate(state.foodExplore!.length, (i){
                      final FoodsModel food = state.foodExplore![i];
                      return FoodTitle(food: food);
                    }),
                  ),
                );
              }
            },
          )
      ),
    );
  }
}
