
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/shimmers/foodlist_shimmer.dart';
import '../../../data/models/hook_models/food_model.dart';
import '../../home/widgets/fastest_food/widgets/food_title.dart';
import '../bloc/restaurant_page_bloc.dart';
class RestaurantExplore extends StatelessWidget {
  const RestaurantExplore({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    context.read<RestaurantPageBloc>().add(FetFoodExploreByCodeRestaurantPageEvent(code:code));
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
                  children: List.generate(state.foodExplore!.length, (i){
                    final FoodsModel food = state.foodExplore![i];
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
