
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/back_ground_container.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/pages/categories/widgets/category_title.dart';

import '../../core/constants/uidata.dart';

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
          child: ListView(
            scrollDirection: Axis.vertical,
            children: List.generate(categories.length, (i) {
              var category = categories[i];
             return CategoryTitle(category: category);
            }),
          ),
        )));
  }
}
