import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/style.dart';

class CardRow extends StatelessWidget {
  final String header;
  final String body;
  final bool alignmentEnd;

  const CardRow(
      {Key? key,
      this.alignmentEnd = false,
      required this.header,
      required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(header.tr,maxLines:3,style: regularDefault.copyWith(color: MyColor.getGreyText(),fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,)),
        const SizedBox(height: Dimensions.space5),
        Text(body.tr,style:regularDefault.copyWith(color:MyColor.smallTextColor1 ))
      ],
    );
  }
}
