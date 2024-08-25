import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:changa_lab/core/utils/my_color.dart';
class CustomSvgPicture extends StatelessWidget {
  final String image;
  final double height, width;
  final Color color;
  final BoxFit? fit;
  final bool ?svgColor;

  const CustomSvgPicture({Key? key, this.fit, required this.image, this.height = 20, this.width = 20, this.color = MyColor.primaryColor,this.svgColor=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fit != null
        ? SvgPicture.asset(image, fit: fit!, colorFilter:svgColor==false?null: ColorFilter.mode(color, BlendMode.srcIn), height: height, width: width)
        : SvgPicture.asset(image,
            colorFilter:svgColor==false?null: ColorFilter.mode(
              color,
              BlendMode.srcIn,
            ),
            height: height,
            width: width);
  }
}
