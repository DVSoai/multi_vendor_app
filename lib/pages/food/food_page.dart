import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/custom_button.dart';
import 'package:multi_vendor_app/common/custom_text_Widget.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/data/models/cart/cart_request_model.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';
import 'package:multi_vendor_app/data/models/hook_models/restaurant_model.dart';
import 'package:multi_vendor_app/pages/food/bloc/food_bloc.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';

import '../../common/app_loader.dart';
import '../../core/di/locator.dart';
import '../../core/network/local/global_storage.dart';
import '../cart/bloc/cart_bloc.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key, required this.food});

  final FoodsModel food;

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late PageController pageController;
  late TextEditingController preferenceController;
  final token = sl<GlobalStorage>().userToken;
  final user = sl<GlobalStorage>().user;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    preferenceController = TextEditingController();
    context.read<FoodPageBloc>().add(LoadAdditives(widget.food.additives));
    // context.read<FoodPageBloc>().add(FetchRestaurantList(code: widget.food.restaurant));
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    preferenceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CartBloc, CartState>(listener: (context, state) {
        if (state.status == CartStatus.loading) {
          AppLoader.show(context);
        } else {
          AppLoader.hide();
        }

        if (state.status == CartStatus.success &&
            state.action == CartAction.add) {
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
      }, child: BlocBuilder<FoodPageBloc, FoodPageState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(30.r)),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 230.h,
                      child: PageView.builder(
                        controller: pageController,
                        onPageChanged: (index) {
                          context
                              .read<FoodPageBloc>()
                              .add(ChangeCurrentPage(currentPage: index));
                        },
                        itemCount: widget.food.imageUrl.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: width,
                            height: 230.h,
                            color: kLightWhite,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.food.imageUrl[index],
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(widget.food.imageUrl.length,
                              (index) {
                            return Container(
                              margin: EdgeInsets.all(4.h),
                              width: 10.w,
                              height: 10.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: state.currentPage == index
                                    ? kSecondary
                                    : kGrayLight,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40.h,
                      left: 12,
                      child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: const Icon(
                          Ionicons.chevron_back_circle,
                          color: kPrimary,
                          size: 30,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 12.w,
                      child: CustomButton(
                        text: 'Open Restaurant',
                        btnWidth: 130.w,
                        onPressed: () async {
                          final RestaurantModel? argument = state.restaurant;
                          context.go(RouterName.restaurantPage,
                              extra: argument);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                            text: widget.food.title,
                            style: appStyle(18, kDark, FontWeight.w600)),
                        ReusableText(
                          text:
                              "\$${((widget.food.price + state.totalPrice!) * state.count!).toStringAsFixed(2)}",
                          style: appStyle(18, kPrimary, FontWeight.w600),
                        )
                      ],
                    ),
                    Gap(5.h),
                    Text(
                      widget.food.description,
                      maxLines: 8,
                      textAlign: TextAlign.justify,
                      style: appStyle(13, kGray, FontWeight.w400),
                    ),
                    Gap(5.h),
                    SizedBox(
                      height: 25.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                            List.generate(widget.food.foodTags.length, (i) {
                          final tag = widget.food.foodTags[i];
                          return Container(
                            height: 25.h,
                            width: 50.w,
                            margin: EdgeInsets.only(right: 5.w),
                            decoration: BoxDecoration(
                              color: kPrimary,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: ReusableText(
                                    text: tag,
                                    style:
                                        appStyle(13, kWhite, FontWeight.w400)),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Gap(15.h),
                    ReusableText(
                        text: 'Additives and Toppings',
                        style: appStyle(18, kDark, FontWeight.w600)),
                    Gap(10.h),
                    Column(
                      children: List.generate(state.additivesList!.length, (i) {
                        final additive = state.additivesList![i];
                        return CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            activeColor: kPrimary,
                            value: additive.isChecked,
                            tristate: false,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReusableText(
                                    text: additive.title,
                                    style:
                                        appStyle(14, kDark, FontWeight.w400)),
                                Gap(5.w),
                                ReusableText(
                                    text: "\$${additive.price}",
                                    style:
                                        appStyle(14, kPrimary, FontWeight.w400))
                              ],
                            ),
                            onChanged: (bool? value) {
                              context
                                  .read<FoodPageBloc>()
                                  .add(ToggleAdditive(i, value!));
                            });
                      }),
                    ),
                    Gap(15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                            text: 'Quantity',
                            style: appStyle(18, kDark, FontWeight.bold)),
                        Gap(5.w),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<FoodPageBloc>()
                                    .add(const IncrementCountEvent(1));
                              },
                              child: const Icon(AntDesign.pluscircleo),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: ReusableText(
                                  text: "${state.count}",
                                  style: appStyle(14, kDark, FontWeight.w600)),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<FoodPageBloc>()
                                    .add(const DecrementCountEvent(1));
                              },
                              child: const Icon(AntDesign.minuscircleo),
                            ),
                          ],
                        )
                      ],
                    ),
                    Gap(15.h),
                    ReusableText(
                        text: 'Preferences',
                        style: appStyle(18, kDark, FontWeight.w600)),
                    Gap(10.h),
                    SizedBox(
                      height: 65.h,
                      child: CustomTextWidget(
                        maxLines: 3,
                        controller: preferenceController,
                        hintText: 'Add a note with your preference',
                      ),
                    ),
                    Gap(15.h),
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (user == null) {
                                context.go(RouterName.loginRedirect);
                              } else if (user?.phoneVerification == false) {
                                showVerificationSheet(context);
                              } else {
                                final RestaurantModel? argument =
                                    state.restaurant;
                                context.push(RouterName.orderPage,
                                    extra: argument);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: ReusableText(
                                  text: "Place Order",
                                  style: appStyle(
                                      18, kLightWhite, FontWeight.w600)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              final double price = double.parse(
                                  ((widget.food.price + state.totalPrice!) *
                                          state.count!)
                                      .toStringAsFixed(2));

                              var cart = CartRequestModel(
                                productId: widget.food.id,
                                additives: state.additiveTitle!,
                                quantity: state.count!,
                                totalPrice: price,
                              );
                              context.read<CartBloc>().add(
                                    AddToCartEvent(cart: cart),
                                  );
                            },
                            child: CircleAvatar(
                              backgroundColor: kSecondary,
                              radius: 20.r,
                              child: const Icon(
                                Ionicons.cart,
                                color: kLightWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(15.h),
                  ],
                ),
              )
            ],
          );
        },
      )),
    );
  }

  Future<dynamic> showVerificationSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        showDragHandle: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 560.h,
            decoration: const BoxDecoration(
              color: kLightWhite,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              image: DecorationImage(
                image: AssetImage('assets/images/restaurant_bk.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(10.h),
                  ReusableText(
                      text: 'Verify Your Phone Number',
                      style: appStyle(18, kPrimary, FontWeight.w600)),
                  SizedBox(
                    height: 280.h,
                    child: Column(
                      children: List.generate(verificationReasons.length, (i) {
                        return ListTile(
                          leading: const Icon(
                            Icons.check_circle_outline,
                            color: kPrimary,
                          ),
                          title: Text(
                            verificationReasons[i],
                            textAlign: TextAlign.justify,
                            style: appStyle(13, kGrayLight, FontWeight.normal),
                          ),
                        );
                      }),
                    ),
                  ),
                  Gap(10.h),
                  CustomButton(
                    text: "Verify Phone Number",
                    btnHeight: 40.h,
                    onPressed: () {
                      context.push(RouterName.phoneVerification);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
