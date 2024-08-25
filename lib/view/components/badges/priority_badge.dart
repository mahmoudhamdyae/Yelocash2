
import 'package:changa_lab/core/utils/style.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/dimensions.dart';

class PriorityBadge extends StatelessWidget {
  final String text;
  final Color color;
  const PriorityBadge({super.key,required this.text,required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(Dimensions.badgeRadius),
        border: Border.all(color:color, width: 1),
      ),
      child: Text(
        text,
        style: regularDefault.copyWith(
          color: color,
        ),
      ),
    );
  }
}
