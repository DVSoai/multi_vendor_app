import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/data/models/hook_models/restaurant_model.dart';
import 'package:multi_vendor_app/pages/categories/all_categories.dart';
import 'package:multi_vendor_app/pages/restaurant/bloc/restaurant_page_bloc.dart';
import 'package:multi_vendor_app/pages/restaurant/widgets/restaurant_bottom_bar.dart';
import 'package:multi_vendor_app/pages/restaurant/widgets/restaurant_explore.dart';
import 'package:multi_vendor_app/pages/restaurant/widgets/restaurant_menu.dart';
import 'package:multi_vendor_app/pages/restaurant/widgets/row_text.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key, this.restaurantModel});

  final RestaurantModel? restaurantModel;

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> with TickerProviderStateMixin {

  late TabController  _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);


  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: ListView(children: [
            Stack(
              children: [
                SizedBox(
                  width: width,
                  height: 230.h,
                  child: CachedNetworkImage(
                    imageUrl: widget.restaurantModel!.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: RestaurantBottomBar(widget: widget),
                ),
                Positioned(
                  top: 5.h,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                           context.go(RouterName.mainPage);
                          },
                         child: const Icon(
                           Ionicons.chevron_back_circle,
                           size: 28,
                           color: kLightWhite,
                         ),
                        ),
                        ReusableText(text: widget.restaurantModel!.title, style: appStyle(16, kDark, FontWeight.w600)),
                        GestureDetector(
                          onTap: () {
                           context.push(RouterName.directionsPage);
                          },
                          child: const Icon(
                            Ionicons.location,
                            size: 28,
                            color: kLightWhite,
                          ),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
            Gap(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const RowText(first: 'Distance to Restaurant', second: '2.7 km'),
                  Gap(3.h),
                  const   RowText(first: 'Estimated Price', second: '\$2.7'),
                  Gap(3.h),
                  const RowText(first: 'Estimated Time', second: '30 min'),
                  const   Divider(
                    thickness: 0.7,
                  )
                ],
              ),
            ),
           Padding(
             padding: EdgeInsets.symmetric(horizontal: 8.w),
             child:  Container(
               height: 25.h,
               width: width,
                decoration: BoxDecoration(
                  color: kLightWhite,
                  borderRadius: BorderRadius.circular(25.r),
                ),

               child: TabBar(
                 indicator: BoxDecoration(
                   color: kPrimary,
                   borderRadius: BorderRadius.circular(25.r),
                 ),
                 labelPadding: EdgeInsets.zero,
                 labelColor: kLightWhite,
                 unselectedLabelColor: kGrayLight,
                 labelStyle: appStyle(12, kLightWhite, FontWeight.normal),
                dividerColor: Colors.transparent,
                 tabs: [
                   Tab(
                     child: SizedBox(
                       width: width/2,
                       height: 25,
                       child: const Center(child: Text('Menu'),),
                     ),
                   ),
                   Tab(
                     child: SizedBox(
                       width: width/2,
                       height: 25,
                       child: const Center(child: Text('Explore'),),
                     ),
                   ),
                 ],
                 controller: _tabController,
               ),
             ),
           ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SizedBox(
                height: height,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    RestaurantMenu(
                      restaurantId: widget.restaurantModel!.id,
                    ),
                    RestaurantExplore(code: widget.restaurantModel!.code,)
                  ],
                ),
              ),
            )
          ]
          ),
        )
    );
  }
}


