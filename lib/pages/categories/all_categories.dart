
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/back_ground_container.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/core/shimmers/foodlist_shimmer.dart';
import 'package:multi_vendor_app/pages/home/bloc/home_bloc.dart';

import '../../routers/routers_name.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ReusableText(
              text: 'Categories',
              style: appStyle(12, kGray, FontWeight.w600)),
          elevation: 0,
          backgroundColor: kOffWhite,
        ),
        body: BackGroundContainer(
          color: kOffWhite,
            child: Container(
          padding: EdgeInsets.only(left: 12.w, top: 10.h),
          height: height,
          child: BlocBuilder<HomeBloc,HomeState>(
              builder:(context, state){
                var categories = state.listCategory;
                if(state.isLoading == true){
                  return const FoodsListShimmer();
                }else {
                   return ListView(
                    scrollDirection: Axis.vertical,
                    children: List.generate(categories.length, (i) {
                      var category = categories[i];
                      return ListTile(
                        onTap: (){
                          debugPrint('CategoryTrue: ${state.listFoodsCategory == null}');
                         if(state.listFoodsCategory== null){
                           context.read<HomeBloc>().add(GetFoodsAll(
                               code: '41007428', category: category.id));
                         }
                          context.pushNamed(RouterName.categoryScreen,extra: category.id,);
                        },
                        leading: CircleAvatar(
                          radius: 18.r,
                          backgroundColor: kGrayLight,
                          child: Image.network(
                            category.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                        title: ReusableText(
                            text: category.title,
                            style: appStyle(12, kGray, FontWeight.normal)),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15.r,
                          color: kGray,
                        ),
                      );
                    }),
                  );
                }
              }
          ),
        )));
  }
}
