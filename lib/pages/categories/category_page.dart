import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/back_ground_container.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/core/shimmers/foodlist_shimmer.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';
import 'package:multi_vendor_app/pages/home/bloc/home_bloc.dart';
import 'package:multi_vendor_app/pages/home/widgets/fastest_food/widgets/food_title.dart';

import '../../common/app_loader.dart';
import '../cart/bloc/cart_bloc.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.category, required this.title});
  final String category;
  final String title;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(GetFoodsAll(code: '41007428', category: widget.category,title: widget.title));
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

        if (state.status == CartStatus.success) {
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

        body: BlocBuilder<HomeBloc,HomeState>(
          builder: (context,state){
            if(state.isLoading == true) {
              return const FoodsListShimmer();
            }else {
              debugPrint("title : ${state.title}");
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title:  ReusableText(text: "${widget.title} Category", style: appStyle(13, kDark, FontWeight.w600)),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  leading: GestureDetector(
                    onTap: (){
                      context.read<HomeBloc>().add(const UpdateCategoryAndTitle(category: '', title: ''));
                      context.pop();
                    },
                    child: const Icon(Icons.arrow_back_ios, color: kDark, size: 20,),
                  ),
                ),
                body: BackGroundContainer(
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
                ),
              );
            }
          },
        ),
      ),
    );

  }
}
