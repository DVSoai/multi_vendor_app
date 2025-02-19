//ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../common/app_style.dart';
import '../../../common/reusable_text.dart';
import '../../../core/constants/constants.dart';
import '../../../routers/routers_name.dart';
import '../bloc/home_bloc.dart';

class CategoryWidget extends StatelessWidget{
  CategoryWidget({super.key, required this.category});
  var category;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state){
        return GestureDetector(
          onTap: () {
            if (state.category == category['_id']) {
              context.read<HomeBloc>().add(
                  const UpdateCategoryAndTitle(category: '', title: ''));
            } else if(category['title'] == 'More') {
              context.pushNamed(
                RouterName.allCategoriesScreen,
              );

            } else {
              context.read<HomeBloc>().add(UpdateCategoryAndTitle(
                  category: category['_id'], title: category['title']));
            }
          },
          child: Container(
            margin: EdgeInsets.only(right: 5.w),
            padding: EdgeInsets.only(top: 4.h),
            width: width * 0.19,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: state.category == category['_id'] ? kSecondary : kOffWhite, width: .5.w),

            ),
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                  child: Image.asset(
                    category['imageUrl'],
                    fit: BoxFit.contain,
                  ),
                ),
                ReusableText(
                    text: category['title'],
                    style: appStyle(12, kDark, FontWeight.normal)),
              ],
            ),
          ),
        );
      },
    );
  }

}
