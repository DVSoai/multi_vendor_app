//ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/pages/home/widgets/categories_widget.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';

import '../../../common/app_style.dart';
import '../../../common/reusable_text.dart';
import '../../../core/constants/constants.dart';

class CategoryTitle extends StatelessWidget{
  CategoryTitle({super.key, required this.category});
  var category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        context.pushNamed(RouterName.categoryScreen);
      },
      leading: CircleAvatar(
        radius: 18.r,
        backgroundColor: kGrayLight,
        child: Image.asset(
          category['imageUrl'],
          fit: BoxFit.contain,
        ),
      ),
      title: ReusableText(
          text: category['title'],
          style: appStyle(12, kGray, FontWeight.normal)),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 15.r,
        color: kGray,
      ),
    );
  }

}
