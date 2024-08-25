import 'package:changa_lab/data/controller/onboard/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/route/route.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import 'indicator.dart';

class CircularButtonWithIndicator extends StatelessWidget {
  final OnboardController controller;

  const CircularButtonWithIndicator({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * .06),
      child: Stack(alignment: Alignment.center, children: [
        AnimatedIndicator(
          duration: const Duration(seconds: 10),
          size: Dimensions.indicatorSize,
          callback: () {},
          indicatorValue: 100 / controller.onboardTitleList.length * (controller.currentIndex.toDouble() + 1),
        ),
        GestureDetector(
          child: Container(
            alignment: Alignment.bottomCenter,
            height: Dimensions.space50,
            width: Dimensions.space50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(99), color: MyColor.primaryColor),
            child: Center(
              child: Icon(
                controller.currentIndex == controller.onboardTitleList.length - 1 ? Icons.check : Icons.arrow_forward_ios_rounded,
                color: MyColor.colorWhite,
              ),
            ),
          ),
          onTap: () {
            if (controller.currentIndex < controller.onboardTitleList.length - 1) {
              controller.controller?.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              Get.offAndToNamed(RouteHelper.loginScreen);
            }
          },
        )
      ]),
    );
  }
}
