import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/common/back_ground_container.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';
import 'package:multi_vendor_app/pages/cart/bloc/cart_bloc.dart';
import 'package:multi_vendor_app/pages/home/widgets/fastest_food/widgets/food_title.dart';
import 'package:multi_vendor_app/pages/search/bloc/search_bloc.dart';

import '../../../common/app_loader.dart';
import '../../../common/app_style.dart';
import '../../../common/reusable_text.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

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
      child: BlocBuilder<SearchBloc, SearchState>(
          builder:(context,state){
            return Container(
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.h, 0),
              height: height,
              child: ListView.builder(
                itemCount: state.searchResults!.length,
                itemBuilder: (context,index){
                  FoodsModel food = state.searchResults![index];
                  return FoodTitle(food: food);
                },
              ),
            );
          }
      ),
    );
  }
}
