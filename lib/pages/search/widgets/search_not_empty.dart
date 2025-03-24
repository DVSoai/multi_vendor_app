import 'package:flutter/material.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:lottie/lottie.dart';

class SearchNotEmpty extends StatelessWidget {
  const SearchNotEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child:  Padding(
        padding: const EdgeInsets.only(bottom: 180),
        child:Column(
          children: [
            Center(child: Text('món ăn bạn tìm kiếm không có',style: appStyle(14, kDark, FontWeight.bold),)),
           const SizedBox(height: 10,),
            LottieBuilder.asset(
              'assets/anime/empty.json',
              width: width,
              height: height/2,
            )
          ],
        ),
      ),
    );
  }
}
