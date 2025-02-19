import 'package:flutter/material.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';

class Recommendations extends StatelessWidget {
  const Recommendations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ReusableText(
            text: 'All Recommendation ',
            style: appStyle(13, kDark, FontWeight.w600)),
        elevation: 0.3,
        backgroundColor: kOffWhite,
      ),
      body: const Center(
        child: Text('Recommendations'),
      ),
    );
  }
}
