
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/core/shimmers/foodlist_shimmer.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';
import 'package:multi_vendor_app/pages/home/widgets/fastest_food/widgets/food_title.dart';
import 'package:multi_vendor_app/pages/restaurant/bloc/restaurant_page_bloc.dart';

import '../../../common/app_loader.dart';
import '../../../common/app_style.dart';
import '../../../common/reusable_text.dart';
import '../../cart/bloc/cart_bloc.dart';


class RestaurantMenu extends StatefulWidget {
  const RestaurantMenu({super.key, required this.restaurantId});
  final String restaurantId;

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantPageBloc>().add(FetFoodByIdRestaurantPageEvent(id: widget.restaurantId));
  }
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
      ),
    );
  }
}
