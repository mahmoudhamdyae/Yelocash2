import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LabelTextInstruction extends StatelessWidget {
  final bool isRequired;
  final String text;
  final String? instructions;
  final TextAlign? textAlign;
  final TextStyle? textStyle;

  const LabelTextInstruction({
    super.key,
    required this.text,
    this.textAlign,
    this.textStyle,
    this.isRequired = false,
    this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> _tooltipKey = GlobalKey<TooltipState>();

    return isRequired
        ? Row(
            children: [
              Text(text.tr, textAlign: textAlign, style: textStyle ?? semiBoldDefault.copyWith(color: MyColor.getLabelTextColor())),
              const SizedBox(
                width: 2,
              ),
              if (instructions != null) ...[
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: Dimensions.space2, end: Dimensions.space10),
                  child: Tooltip(
                      key: _tooltipKey,
                      message: "$instructions",
                      child: GestureDetector(
                        onTap: () {
                          _tooltipKey.currentState?.ensureTooltipVisible();
                        },
                        child: Icon(
                          Icons.info_outline_rounded,
                          size: Dimensions.space15,
                          color: Theme.of(context).textTheme.titleLarge!.color?.withOpacity(0.8),
                        ),
                      )),
                ),
              ],
              Text(
                '*',
                style: semiBoldDefault.copyWith(color: MyColor.getRedColor()),
              ),
            ],
          )
        : Row(
            children: [
              Text(
                text.tr,
                textAlign: textAlign,
                style: textStyle ?? semiBoldDefault.copyWith(color: MyColor.getLabelTextColor()),
              ),
              if (instructions != null) ...[
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: Dimensions.space2, end: Dimensions.space10),
                  child: Tooltip(
                      key: _tooltipKey,
                      message: "$instructions",
                      child: GestureDetector(
                        onTap: () {
                          _tooltipKey.currentState?.ensureTooltipVisible();
                        },
                        child: Icon(
                          Icons.info_outline_rounded,
                          size: Dimensions.space15,
                          color: MyColor.getLabelTextColor().withOpacity(0.8),
                        ),
                      )),
                ),
              ],
            ],
          );
  }
}
