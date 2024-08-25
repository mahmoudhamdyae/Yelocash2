import 'package:flutter/material.dart';
import 'package:changa_lab/core/utils/my_color.dart';

class RoundedLoadingBtn extends StatelessWidget {
  final Color? textColor;
  final Color? color;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;

  const RoundedLoadingBtn({
    super.key,
    this.width = 1,
    this.cornerRadius = 4,
    this.horizontalPadding = 35,
    this.verticalPadding = 17,
    this.textColor = MyColor.colorWhite,
    this.color = MyColor.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding - 3),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(cornerRadius)),
        child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: textColor, strokeWidth: 3))),
      ),
    );
  }
}
