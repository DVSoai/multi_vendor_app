import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/common/custom_button.dart';
import 'package:multi_vendor_app/pages/profile/widgets/profile_app_bar.dart';
import 'package:multi_vendor_app/pages/profile/widgets/profile_title_widget.dart';
import 'package:multi_vendor_app/pages/profile/widgets/user_info_widget.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';

import '../../common/custom_container.dart';
import '../../core/constants/constants.dart';
import '../../core/di/locator.dart';
import '../../core/network/local/global_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('user image ${sl<GlobalStorage>().user!.profile}');
    debugPrint('username ${sl<GlobalStorage>().user?.username}');
    debugPrint('email ${sl<GlobalStorage>().user?.email}');
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.h), child: const ProfileAppBar()),
      body: SafeArea(
          child: CustomContainer(
              containerContent: Column(
        children: [
          UserInfoWidget(
            username: sl<GlobalStorage>().user?.username ?? 'Marshal',
            email: sl<GlobalStorage>().user?.email ?? 'MarshalDev@gmail.com',
            image: sl<GlobalStorage>().user?.profile ??
                'https://images2.thanhnien.vn/528068263637045248/2024/1/25/e093e9cfc9027d6a142358d24d2ee350-65a11ac2af785880-17061562929701875684912.jpg',
          ),
          Gap(10.h),
          Container(
            height: 185.h,
            decoration: const BoxDecoration(
              color: kLightWhite,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ProfileTitleWidget(
                  title: 'My Orders',
                  icon: Ionicons.fast_food_outline,
                  onTap: () {
                    context.push(RouterName.loginRedirect);
                  },
                ),
                ProfileTitleWidget(
                  title: 'My Favorite Places',
                  icon: Ionicons.heart_outline,
                  onTap: () {},
                ),
                ProfileTitleWidget(
                  title: 'Review',
                  icon: Ionicons.chatbubble_outline,
                  onTap: () {},
                ),
                ProfileTitleWidget(
                  title: 'Coupons',
                  icon: MaterialCommunityIcons.tag_outline,
                  onTap: () {},
                ),
              ],
            ),
          ),
          Gap(15.h),
          Container(
            height: 185.h,
            decoration: const BoxDecoration(
              color: kLightWhite,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ProfileTitleWidget(
                  title: 'Shipping Address',
                  icon: SimpleLineIcons.location_pin,
                  onTap: () {},
                ),
                ProfileTitleWidget(
                  title: 'Service center',
                  icon: AntDesign.customerservice,
                  onTap: () {},
                ),
                ProfileTitleWidget(
                  title: 'Coupons',
                  icon: MaterialIcons.rss_feed,
                  onTap: () {},
                ),
                ProfileTitleWidget(
                  title: 'Settings',
                  icon: AntDesign.setting,
                  onTap: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: CustomButton(
              text: 'Log Out',
              onPressed: () {
                sl<GlobalStorage>().clearUser();
                context.go(RouterName.loginPage);
              },
              btnColor: kRed,
            ),
          ),
        ],
      ))),
    );
  }
}
