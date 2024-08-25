// ignore_for_file: must_be_immutable
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivitiCard extends StatelessWidget {
  String name, value, imgPath;
  bool isusd;
  ActivitiCard(
      {super.key,
      required this.name,
      required this.value,
      required this.imgPath,
      required this.isusd});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(4),
        // height: 70,
        // width: 164,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: MyColor.white,
          border: Border.all(
            color: MyColor.borderColor,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // we will use hare custom circle avatars
            CircleAvatar(
              backgroundColor: MyColor.primary,
              child: SvgPicture.asset(
                imgPath,
              ),
            ),
            const SizedBox(
              width: Dimensions.space10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: appHeading.copyWith(
                      color: MyColor.title,
                      fontWeight: FontWeight.w700,
                      fontSize: Dimensions.fontMediumLarge,
                    ),
                  ),
                  Text(
                    name,
                    style: appHeading.copyWith(
                      color: MyColor.body1,
                      fontSize: Dimensions.Text10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
