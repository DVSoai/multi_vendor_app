import 'package:flutter/material.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:lottie/lottie.dart';

class SearchLoadingWidget extends StatelessWidget {
  const SearchLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 180),
        child: LottieBuilder.asset(
          'assets/anime/delivery.json',
          width: width,
          height: height/2,
        ),
      ),
    );
  }
}
