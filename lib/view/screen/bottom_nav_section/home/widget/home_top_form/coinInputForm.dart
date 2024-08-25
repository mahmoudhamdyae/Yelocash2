import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class coininputform extends StatelessWidget {
  String name;
  bool isSvg;
  String imgPath;
  String moneyname;
  bool showArrow = true;
  double maxRadious = 14;
  Color color = Colors.transparent;
  coininputform({
    super.key,
    required this.name,
    required this.isSvg,
    required this.imgPath,
    required this.moneyname,
    this.showArrow = true,
    this.maxRadious = 14,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        boxShadow: MyUtils.getCardShadow(),
        shape: BoxShape.circle,
      ),
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        spacing: 10,
        children: [
          isSvg
              ? CircleAvatar(
                  maxRadius: maxRadious,
                  backgroundColor: color,
                  backgroundImage: NetworkImage(imgPath),
                  child: SvgPicture.asset(imgPath),
                )
              : CircleAvatar(
                  maxRadius: 16,
                  backgroundColor: color,
                  backgroundImage: NetworkImage(imgPath),
                ),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              '$name $moneyname',
              style:
                  bodyText.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          showArrow
              ? SvgPicture.asset(
                  MyImages.angelSmallDownArrow,
                  fit: BoxFit.scaleDown,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
