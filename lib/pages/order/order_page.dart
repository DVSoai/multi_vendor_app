import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/back_ground_container.dart';
import 'package:multi_vendor_app/common/custom_button.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/data/models/hook_models/restaurant_model.dart';
import 'package:multi_vendor_app/data/models/order/order_request_model.dart';
import 'package:multi_vendor_app/pages/order/widgets/order_title.dart';
import 'package:multi_vendor_app/pages/restaurant/widgets/row_text.dart';

import '../../data/models/hook_models/food_model.dart';

class OrderPage extends StatefulWidget {
  const OrderPage(
      {super.key,
      this.restaurant,
      required this.foodModel,
      required this.item});

  final RestaurantModel? restaurant;
  final FoodsModel foodModel;
  final OrderItem item;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.item.additives);
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: ReusableText(
            text: 'Complete Ordering',
            style: appStyle(13, kLightWhite, FontWeight.w600)),
        centerTitle: true,
      ),
      body: BackGroundContainer(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Gap(10.h),
              OrderTitle(food: widget.foodModel),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                width: width,
                height: height / 4,
                decoration: BoxDecoration(
                  color: kOffWhite,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                            text: widget.restaurant!.title,
                            style: appStyle(20, kGray, FontWeight.bold)),
                        CircleAvatar(
                          radius: 18.r,
                          backgroundColor: kPrimary,
                          backgroundImage:
                              NetworkImage(widget.restaurant!.logoUrl),
                        ),
                      ],
                    ),
                    Gap(5.h),
                    RowText(
                        first: 'Business Hours',
                        second: widget.restaurant!.time),
                    Gap(5.h),
                    const RowText(first: 'Distance from Restaurant', second: "3 km"),
                    Gap(5.h),
                    const RowText(first: 'Price from Restaurant', second: "\$ 4.00"),
                    Gap(5.h),
                    RowText(
                        first: 'Order Total',
                        second: "\$ ${widget.item.price.toString()}"),
                    Gap(5.h),
                    ReusableText(text: 'Additives', style: appStyle(20, kGray, FontWeight.bold)),
                    Gap(5.h),
                    SizedBox(
                      width: width,
                      height: 20.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.item.additives.length,
                        itemBuilder: (context, i) {
                          String additive = widget.item.additives[i];
                          return Container(
                            margin: EdgeInsets.only(right: 5.w),
                            decoration: BoxDecoration(
                              color: kSecondaryLight,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9.r)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Center(
                                child: ReusableText(
                                    text: additive,
                                    style: appStyle(11, kGray, FontWeight.w400)),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Gap(20.h),
              CustomButton(
                text: "Proceed to Payment",
                btnHeight: 45.h,
                onPressed: () {
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
