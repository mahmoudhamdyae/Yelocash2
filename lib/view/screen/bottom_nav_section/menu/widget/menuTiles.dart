import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/view/components/image/custom_svg_picture.dart';
import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  bool isSvg;
  String imagePath, title;
  VoidCallback action;

  MenuTile(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.isSvg,
      required this.action
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.space5, horizontal: Dimensions.space10),
        color: MyColor.transparentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: MyColor.screenBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: isSvg
                      ? CustomSvgPicture(
                          image: imagePath,
                          color: MyColor.colorBlack,
                          height: 17.5,
                          width: 17.5)
                      : Image.asset(imagePath,
                          color: MyColor.colorBlack, height: 17.5, width: 17.5),
                ),
                const SizedBox(width: Dimensions.space15),
                Text(title,
                    style: regularDefault.copyWith(color: MyColor.colorBlack))
              ],
            ),
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: MyColor.transparentColor, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_forward_ios_rounded,
                  color: MyColor.colorBlack, size: 15),
            ),
          ],
        ),
      ),
    );
  }
}
