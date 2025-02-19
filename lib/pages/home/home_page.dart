import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/common/custom_container.dart';
import 'package:multi_vendor_app/common/heading.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/pages/categories/widgets/category_title.dart';
import 'package:multi_vendor_app/pages/home/widgets/categories_list.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';

import '../../common/custom_app_bar.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: Scaffold(
        backgroundColor: kPrimary,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(130.h),
            child: const CustomAppBar()
        ),
        body:SafeArea(
            child:  CustomContainer(
                containerContent: Column(
                  children: [
                   const CategoriesList(),
                    Heading(title: 'Nearby Restaurants', onTap: () {
                      context.pushNamed(RouterName.allNearbyRestaurants);
                    }),
                    Heading(title: 'Try Something New', onTap: () {
                      context.pushNamed(RouterName.recommendations);
                    }),
                    Heading(title: 'Fastest food closer to you', onTap: () {
                      context.pushNamed(RouterName.allFastestFood);
                    }),

                  ],
                ))),
      ),
    );
  }
}
