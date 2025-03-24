import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/core/shimmers/foodlist_shimmer.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';
import 'package:multi_vendor_app/pages/home/bloc/home_bloc.dart';
import 'package:multi_vendor_app/pages/home/widgets/fastest_food/widgets/food_title.dart';

class CategoryFoodsList extends StatefulWidget {
  const CategoryFoodsList({super.key});

  @override
  State<CategoryFoodsList> createState() => _CategoryFoodsListState();
}

class _CategoryFoodsListState extends State<CategoryFoodsList> {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {

        return SizedBox(
          width: width,
          height: height,
          child: state.isLoading == true
              ? const FoodsListShimmer()
              : Padding(
            padding: EdgeInsets.all(12.h),
            child: ListView(
              children: List.generate(state.listFoodsCategory!.length, (i) {
                FoodsModel foods = state.listFoodsCategory![i];
                return FoodTitle(food: foods,color: Colors.white,);
              }),
            ),
          ),
        );
      },
    );
  }
}
