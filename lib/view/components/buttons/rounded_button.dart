import 'package:changa_lab/core/utils/my_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:changa_lab/core/utils/my_color.dart';

class RoundedButton extends StatelessWidget {
  final bool isColorChange;
  final String text;
  final VoidCallback press;
  final Color color;
  final Color? textColor;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;
  final bool isOutlined;
  final Widget? child;
  final Widget?logo;

  const RoundedButton({
    Key? key,
    this.isColorChange = false,
    this.width = 1,
    this.child,
    this.cornerRadius = 6,
    required this.text,
    required this.press,
    this.isOutlined = false,
    this.horizontalPadding = 35,
    this.verticalPadding = 15,
    this.color = MyColor.primaryColor,
    this.textColor = MyColor.colorWhite,
    this.logo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return child != null
        ? InkWell(
            onTap: press,
            splashColor: MyColor.getScreenBgColor(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              width: size.width * width,
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(cornerRadius),
                color: isColorChange ? color : MyColor.getPrimaryButtonColor(),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (logo != null) ...[
                      logo!, // Add logo only if it's not null
                      const SizedBox(width: 4), // Add spacing if logo is present
                    ],                    SizedBox(width: 4,),
                    Text(
                      text.tr,
                      style: TextStyle(
                        color: isColorChange ? textColor : MyColor.getSecondaryButtonTextColor(),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : isOutlined
            ? Material(
                child: InkWell(
                  onTap: press,
                  splashColor: MyColor.getScreenBgColor(),
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                      width: size.width * width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(cornerRadius), color: isColorChange ? color : MyColor.getPrimaryButtonColor()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (logo != null) ...[
                            logo!, // Add logo only if it's not null
                            const SizedBox(width: 4), // Add spacing if logo is present
                          ],SizedBox(width: 4,),
                          Text(
                            text.tr,
                            style: TextStyle(
                              color: isColorChange ? textColor : MyColor.getSecondaryButtonTextColor(),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )),
                ),
              )
            : SizedBox(
                width: size.width * width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(cornerRadius),
                  child: ElevatedButton(
                    onPressed: press,
                    style: ElevatedButton.styleFrom(backgroundColor: color, shadowColor: MyColor.transparentColor, padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding), textStyle: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
                    child: Text(
                      text.tr,
                      style: TextStyle(color: textColor),
                    ),
                  ),
                ),
              );
  }
}
