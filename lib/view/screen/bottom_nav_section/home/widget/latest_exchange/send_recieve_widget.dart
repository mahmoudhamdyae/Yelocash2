// ignore_for_file: must_be_immutable

import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SendReceive extends StatelessWidget {
  bool isSvg;
  String imgPath, name;

  SendReceive({
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
        SizedBox(
          height: 20,
          width: 20,
          child: CircleAvatar(
              maxRadius: 14,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(imgPath),
              child: isSvg
                  ? SvgPicture.asset(
                      imgPath,
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink()),
        ),
        const SizedBox(
          width: 5,
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
