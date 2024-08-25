import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SendReceived extends StatelessWidget {
  bool isSvg;
  String imgPath, name;
  SendReceived({
    super.key,
    required this.isSvg,
    required this.imgPath,
    required this.name,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
            maxRadius: 14,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(imgPath),
            child: isSvg ? SvgPicture.asset(imgPath) : const SizedBox.shrink()),
        const SizedBox(
          width: Dimensions.space5,
        ),
        Text(
          name,
          style: bodyText.copyWith(
            color: MyColor.title,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
