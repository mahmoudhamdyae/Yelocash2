// import 'package:changa_lab/core/route/route.dart';
// import 'package:changa_lab/core/utils/dimensions.dart';
// import 'package:changa_lab/core/utils/my_color.dart';
// import 'package:changa_lab/core/utils/my_images.dart';
// import 'package:changa_lab/core/utils/my_strings.dart';
// import 'package:changa_lab/data/controller/dashboard/dashboard_controller.dart';
// import 'package:changa_lab/data/controller/home/home_controller.dart';
// import 'package:changa_lab/view/components/circle_image_button.dart';
// import 'package:changa_lab/view/components/image/custom_svg_picture.dart';
// import 'package:changa_lab/view/components/shape/SquareShape.dart';
// import 'package:flutter/material.dart';
// import 'package:changa_lab/core/utils/style.dart';
// import 'package:changa_lab/view/components/shape/CurcleShape.dart';
// import 'dart:math' as math;
// import 'package:get/get.dart';
//
// class HomeAppBar extends StatelessWidget {
//   const HomeAppBar({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//       Container(
//       color: MyColor.appBarColor,
//       padding: const EdgeInsets.all(16),
//       height: 250,
//       ),
//         Positioned(
//           right: -50,
//           top: -10,
//           child: CustomPaint(
//             painter: MyCirclePainter(),
//             size: Size(Get.width / 3, Get.height / 3),
//           ),
//         ),
//         Positioned(
//           left: -140,
//           top: -90,
//           child: Transform.rotate(
//             angle: -math.pi / 6,
//             child: CustomPaint(
//               painter: MySqarePainter(),
//               size: Size(Get.width, Get.height / 2),
//             ),
//           ),
//         ),
//
//         GetBuilder<HomeController>(builder: (controller) {
//           return Container(
//             color: MyColor.transparentColor,
//             padding: const EdgeInsets.all(16),
//             height: 250,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // we will use hare custom circle avatars
//                     CircleImageWidget(
//                         height: 40,
//                         width: 40,
//                         isProfile: true,
//                         isAsset: true,
//                         imagePath: MyImages.profile,
//                         // '${UrlContainer.domainUrl}/assets/images/user/profile/${controller.imagePath}',
//                         press: () {
//                           Get.toNamed(RouteHelper.profileScreen);
//                         }),
//
//                     const SizedBox(
//                       width: Dimensions.space10,
//                     ),
//                     GetBuilder<DashboardController>(builder: (dashcontroller) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           RichText(
//                             text: TextSpan(
//                               text: double.parse(dashcontroller.balance).toStringAsFixed(2),
//                               style: appHeading.copyWith(
//                                 color: MyColor.white,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 18,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: ' ${controller.defaultCurrency}',
//                                   style: bodyText.copyWith(
//                                     color: MyColor.white,
//                                     // fontWeight: FontWeight.w400,
//                                     // fontSize: Dimensions.Text17,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Text(
//                             MyStrings.currentBalance.tr,
//                             style: appHeading.copyWith(
//                               color: MyColor.white,
//                               fontSize: Dimensions.Text12,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ],
//                       );
//                     }),
//                   ],
//                 ),
//                 InkWell(
//                   onTap: () {
//                       Get.toNamed(RouteHelper.languageScreen);
//                   },
//                   child: Container(
//                     height: 30,
//                     width: 30,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(color: MyColor.borderColor, borderRadius: BorderRadius.circular(8)
//                     ),
//                     child: const CustomSvgPicture(
//                       image: MyImages.language,
//                       color: MyColor.colorBlack,
//                       height: 18,
//                       width: 18,
//                       fit: BoxFit.scaleDown,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         }),
//       ],
//     );
//   }
// }

import 'package:changa_lab/core/helper/shared_preference_helper.dart';
import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/circle_image_button.dart';
import 'package:changa_lab/view/components/image/custom_svg_picture.dart';
import 'package:flutter/material.dart';
import 'package:changa_lab/core/utils/style.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: MyColor.appBarColor,
          padding: const EdgeInsets.all(16),
          height: 250,
        ),
        Positioned(
          left: -16,
          top: 60,
          child: Image.asset(
            MyImages.c1,
            width: 155,
            height: 139,
          ),
        ),
        Positioned(
          left: 47,
          top: 30,
          child: Image.asset(
            MyImages.c2,
            width: 118,
            height: 118,
          ),
        ),
        Positioned(
          right: -40,
          top: -4,
          child: Image.asset(
            MyImages.v3,
            width: 182,
            height: 198,
          ),
        ),
        Positioned(
          right: -45,
          top: -24,
          child: Transform.rotate(
            angle: 0,
            child: Image.asset(
              MyImages.v2,
              width: 240,
              height: 197,
            ),
          ),
        ),
        Positioned(
          right: -35,
          top: -40,
          child: Transform.rotate(
            angle: 0,
            child: Image.asset(
              MyImages.v1,
              width: 210,
              height: 197,
            ),
          ),
        ),

        GetBuilder<HomeController>(builder: (controller) {
          return Container(
            color: MyColor.transparentColor,
            padding: const EdgeInsets.all(16),
            height: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // we will use hare custom circle avatars
                    CircleImageWidget(
                        height: 40,
                        width: 40,
                        isProfile: true,
                        isAsset: true,
                        imagePath: MyImages.profile,
                        // '${UrlContainer.domainUrl}/assets/images/user/profile/${controller.imagePath}',
                        press: () {
                          Get.toNamed(RouteHelper.profileScreen);
                        }),

                    const SizedBox(
                      width: Dimensions.space10,
                    ),
                    GetBuilder<DashboardController>(builder: (dashcontroller) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: double.parse(dashcontroller.balance).toStringAsFixed(2),
                              style: appHeading.copyWith(
                                color: MyColor.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                              children: [
                                TextSpan(
                                  text: ' ${controller.defaultCurrency}',
                                  style: bodyText.copyWith(
                                    color: MyColor.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            MyStrings.currentBalance.tr,
                            style: appHeading.copyWith(
                              color: MyColor.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.languageScreen);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: MyColor.borderColor, borderRadius: BorderRadius.circular(8)
                      // shape: BoxShape.circle,
                    ),
                    child: const CustomSvgPicture(
                      image: MyImages.language,
                      color: MyColor.colorBlack,
                      height: 18,
                      width: 18,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ],
    );
  }
}

