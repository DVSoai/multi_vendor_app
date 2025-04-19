import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/common/app_loader.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/back_ground_container.dart';
import 'package:multi_vendor_app/common/custom_button.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/core/shimmers/foodlist_shimmer.dart';
import 'package:multi_vendor_app/pages/auth/login/email_verification/email_verification.dart';
import 'package:multi_vendor_app/pages/profile/address/bloc/address_bloc.dart';
import 'package:multi_vendor_app/pages/profile/address/widgets/addresses_list_widget.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';

class AddressesPage extends StatefulWidget {
  const AddressesPage({super.key});

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kOffWhite,
        centerTitle: true,
        title: ReusableText(text: 'Address', style: appStyle(13, kGray, FontWeight.w600)),
      ),
      body:BlocBuilder<AddressBloc,AddressState>(
        builder: (context,state){
          if(state.isLoading == true){
          return const FoodsListShimmer();
          }else if(state.isError == true){
            return Center(
              child: ReusableText(text: state.errorMessage, style: appStyle(13, kGray, FontWeight.w600)),
            );
          } else {
            return BackGroundContainer(
              color: kOffWhite,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 12.w,
                      right: 12.w,
                      bottom: 80.h
                    ),
                    child: AddressesListWidget(
                      addresses: state.addresses,),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 20.h),
                      child: CustomButton(
                        text: 'Add Address',
                        onPressed: () async {
                          final result = await context.push<bool>(RouterName.shippingAddress);
                          if (result == true) {
                            context.read<AddressBloc>().add(const GetAddressesEvent());
                          }
                        },
                        btnHeight: 50.h,
                      ),

                    ),
                  )
                ],
              ),
            );
          }

        },
      ),
    );
  }
}
