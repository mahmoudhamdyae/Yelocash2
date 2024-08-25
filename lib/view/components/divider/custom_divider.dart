import 'package:flutter/material.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';

class CustomDivider extends StatelessWidget {

  final double thickness;
  final double bottomSpace;
  final Color color;
  final double topSpace;

  const CustomDivider(
      {Key? key,
      this.topSpace = Dimensions.space15,
      this.bottomSpace = Dimensions.space15,
      this.thickness = 0.5,
      this.color = MyColor.colorBlack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: topSpace),
        Divider(
          color: color.withOpacity(0.2),
          height: 0.5,
          thickness: thickness,
        ),
        SizedBox(height: bottomSpace),
      ],
    );
  }
}
