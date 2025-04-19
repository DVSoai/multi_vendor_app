import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/shimmers/foodlist_shimmer.dart';
import 'package:multi_vendor_app/pages/cart/bloc/cart_bloc.dart';
import 'package:multi_vendor_app/pages/cart/widgets/cart_title.dart';

import '../../common/app_loader.dart';
import '../../common/custom_container.dart';
import '../../core/constants/constants.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context,state){
        if (state.status == CartStatus.success && state.action == CartAction.remove) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              content: ReusableText(
                  text: "Delete from cart",
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
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: kPrimary,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: kOffWhite,
              title: ReusableText(
                  text: 'Cart', style: appStyle(14, kGray, FontWeight.w600)),
            ),
            body: SafeArea(
                child: CustomContainer(
                  containerContent: state.status == CartStatus.loading
                      ? const FoodsListShimmer()
                      : Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 12.w),
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: ListView.builder(
                        itemCount: state.listCart.length,
                        itemBuilder: (context, i) {
                          return CartTitle(cart: state.listCart[i],color: kWhite,);
                        },
                      ),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
