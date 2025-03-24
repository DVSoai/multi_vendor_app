import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/common/back_ground_container.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';
import 'package:multi_vendor_app/pages/home/widgets/fastest_food/widgets/food_title.dart';
import 'package:multi_vendor_app/pages/search/bloc/search_bloc.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
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
    );
  }
}
