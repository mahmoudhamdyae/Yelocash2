import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryPicker extends StatefulWidget {
  final String text;
  final VoidCallback press;
  final bool isShowIcon;
  const CountryPicker(
      {super.key,
      required this.text,
      required this.press,
      this.isShowIcon = false});

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.space15, horizontal: Dimensions.space15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
            border: Border.all(
                color: MyColor.getTextFieldDisableBorder(), width: .5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.isShowIcon
                ? Row(
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: SvgPicture.asset(
                          MyImages.internet,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.text,
                        style: regularMediumLarge.copyWith(
                          fontSize: Dimensions.Text16,
                          color: MyColor.hintTextColor,
                        ),
                      ),
                    ],
                  )
                : Text(
                    widget.text,
                    style: regularMediumLarge.copyWith(
                      fontSize: Dimensions.fontDefault,
                      color: widget.text.toLowerCase() ==
                              MyStrings.country.toLowerCase()
                          ? MyColor.hintTextColor
                          : MyColor.title,
                    ),
                  ),
            SizedBox(
              width: 22,
              height: 22,
              child: SvgPicture.asset(
                MyImages.angelSmallDownArrow,
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
