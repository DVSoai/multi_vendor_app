
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/core/shimmers/foodlist_shimmer.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';
import 'package:multi_vendor_app/pages/home/widgets/fastest_food/widgets/food_title.dart';
import 'package:multi_vendor_app/pages/restaurant/bloc/restaurant_page_bloc.dart';


class RestaurantMenu extends StatelessWidget {
  const RestaurantMenu({super.key, required this.restaurantId});
  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    context.read<RestaurantPageBloc>().add(FetFoodByIdRestaurantPageEvent(id: restaurantId));
    return Scaffold(
      backgroundColor: kLightWhite,
      body: BlocBuilder<RestaurantPageBloc,RestaurantPageState>(
        builder: (context,state){
          if(state.isLoading == true){
            return const FoodsListShimmer();
          }else {
            return SizedBox(
              height: height* 0.7,
              child: ListView(
                children: List.generate(state.food!.length, (i){
                  final FoodsModel food = state.food![i];
                  return FoodTitle(food: food);
                }),
              ),
            );
          }
        },
      )
    );
  }
}
