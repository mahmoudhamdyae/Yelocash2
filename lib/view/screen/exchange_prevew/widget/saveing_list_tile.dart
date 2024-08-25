import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SavinglistTile extends StatelessWidget {
  final String name, value;
  String? usd;

  bool isSendingCharged = false;
  bool? isbottomDevider;
  bool? isTitleBold;
  bool? isSubTitleBold;
  SavinglistTile({
    required this.name,
    required this.value,
    this.isbottomDevider = true,
    this.isSendingCharged = true,
    this.usd = 'USD',
    this.isTitleBold = false,
    this.isSubTitleBold = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: bodyText.copyWith(
                  fontWeight: isTitleBold! ? FontWeight.bold : FontWeight.w400,
                ),
              ),
              isSendingCharged
                  ? RichText(
                      text: TextSpan(
                          text: value,
                          style: bodyText.copyWith(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFE91C1C),
                          ),
                          children: [
                            TextSpan(
                              text: ' $usd',
                              style: bodyText.copyWith(
                                fontWeight: FontWeight.w500,
                                color: MyColor.body2,
                              ),
                            ),
                          ]),
                    )
                  : Text(
                      value,
                      textAlign: TextAlign.right,
                      style: bodyText.copyWith(
                        fontWeight:
                            isSubTitleBold! ? FontWeight.bold : FontWeight.w500,
                        color: MyColor.body2,
                      ),
                    ),
            ],
          ),
          isbottomDevider!
              ? const SizedBox(
                  height: Dimensions.space10,
                )
              : const SizedBox(),
          isbottomDevider!
              ? const Divider(
                  color: MyColor.borderColor,
                  height: 2,
                )
              : const SizedBox(
                  height: Dimensions.space2,
                ),
        ],
      ),
    );
  }
}
