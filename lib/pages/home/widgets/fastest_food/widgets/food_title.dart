import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/common/app_loader.dart';
import 'package:multi_vendor_app/common/custom_app_bar.dart';
import 'package:multi_vendor_app/data/models/cart/cart_request_model.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';
import 'package:multi_vendor_app/pages/cart/bloc/cart_bloc.dart';
import 'package:multi_vendor_app/pages/categories/all_categories.dart';
import 'package:multi_vendor_app/pages/food/food_page.dart';
import '../../../../../common/app_style.dart';
import '../../../../../common/reusable_text.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../routers/routers_name.dart';

class FoodTitle extends StatelessWidget {
  const FoodTitle({super.key, required this.food, this.color});

  final FoodsModel food;
  final Color? color;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () {
      context.push(RouterName.foodPage, extra: food);
    },
    child: Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8.w),
          height: 70.h,
          width: width,
          decoration: BoxDecoration(
            color: color ?? kOffWhite,
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Container(
            padding: EdgeInsets.all(4.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 70.w,
                        height: 70.h,
                        child: Image.network(food.imageUrl[0],
                            fit: BoxFit.cover),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.only(left: 6.w, bottom: 2.h),
                          color: kGray.withOpacity(0.6),
                          height: 16.h,
                          width: width,
                          child: RatingBarIndicator(
                            rating: 5,
                            itemCount: 5,
                            itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: kSecondary),
                            itemSize: 15.h,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: food.title,
                        style: appStyle(11, kDark, FontWeight.w400)),
                    ReusableText(
                        text: "Delivery time : ${food.time}",
                        style: appStyle(11, kGray, FontWeight.w400)),
                    SizedBox(
                      width: width * 0.7,
                      height: 18.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: food.additives.length,
                        itemBuilder: (context, index) {
                          var additive = food.additives[index];
                          return Container(
                            margin: EdgeInsets.only(right: 5.w),
                            decoration: BoxDecoration(
                              color: kSecondaryLight,
                              borderRadius:
                              BorderRadius.all(Radius.circular(9.r)),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(2.h),
                                child: ReusableText(
                                  text: additive.title,
                                  style: appStyle(10, kDark, FontWeight.w400),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: 5.w,
          top: 6.h,
          child: Container(
            width: 60.w,
            height: 19.h,
            decoration: BoxDecoration(
              color: kPrimary,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
                child: ReusableText(
                    text: "\$${food.price}",
                    style: appStyle(12, kLightWhite, FontWeight.bold))),
          ),
        ),
        Positioned(
          right: 75.w,
          top: 6.h,
          child: GestureDetector(
            onTap: () {
              final additivesAsStrings = food.additives.map((additive) => additive.title).toList();
              final cart = CartRequestModel(productId: food.id, additives: additivesAsStrings, quantity: 1, totalPrice: food.price);
              context.read<CartBloc>().add( AddToCartEvent(cart: cart));

            },
            child: Container(
              width: 19.w,
              height: 19.h,
              decoration: BoxDecoration(
                color: kSecondary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Icon(
                  MaterialCommunityIcons.cart_plus,
                  size: 15.h,
                  color: kLightWhite,
                ),
              ),
            ),
          ),
        )
      ],
    ),
          );
  }
}
