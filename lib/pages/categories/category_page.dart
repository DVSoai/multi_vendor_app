import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/common/back_ground_container.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/core/shimmers/foodlist_shimmer.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';
import 'package:multi_vendor_app/pages/home/bloc/home_bloc.dart';
import 'package:multi_vendor_app/pages/home/home_page.dart';
import 'package:multi_vendor_app/pages/home/widgets/fastest_food/widgets/food_title.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.category});
  final String category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(GetFoodsAll(code: '41007428', category: widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Categories'),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<HomeBloc,HomeState>(
        builder: (context,state){
        if(state.isLoading == true) {
          return const FoodsListShimmer();
        }else {
          debugPrint('Category123: ${state.listFoodsCategory!.length}');
          return BackGroundContainer(
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.only(left: 12.w,top: 10.h),
              height: height,
              child:ListView(
                children: List.generate(state.listFoodsCategory!.length, (i){
                  FoodsModel food = state.listFoodsCategory![i];
                  return FoodTitle(
                    food: food,
                    color: Colors.white,
                  );
                }),
              ) ,
            ),
          );
        }
        },
      ),
    );

  }
}
