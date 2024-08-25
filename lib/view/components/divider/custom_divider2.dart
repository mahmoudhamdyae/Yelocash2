import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:flutter/material.dart';
 

class CustomDivider2 extends StatelessWidget {

  final double space;
  final Color color;
  final bool isOpacityEnable;

  const CustomDivider2({
    Key? key,
    this.space = Dimensions.space20,
    this.color = MyColor.colorBlack,
    this.isOpacityEnable = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: space),
        Divider(color: isOpacityEnable?color.withOpacity(0.2):color, height: 0.5, thickness: 0.5),
        SizedBox(height: space),
      ],
    );
  }
}
