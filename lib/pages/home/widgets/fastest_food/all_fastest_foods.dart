import 'package:flutter/material.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';

import '../../../../common/app_style.dart';
import '../../../../common/reusable_text.dart';

class AllFastestFoods extends StatelessWidget {
  const AllFastestFoods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ReusableText(
            text: 'Fastest Foods',
            style: appStyle(13, kGray, FontWeight.w600)),
        elevation: 0.3,
        backgroundColor: kOffWhite,
      ),
      body: const Center(
        child:  Text('Fastest Foods'),
      ),
    );
  }
}
