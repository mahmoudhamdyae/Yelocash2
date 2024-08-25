import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/model/commission_log/commission_log_model.dart';
import 'package:changa_lab/view/components/image/custom_svg_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommissionCard extends StatelessWidget {
  Commission commission;
  String currency;

  CommissionCard({super.key, required this.commission, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: MyColor.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '#${commission.title}',
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: heading.copyWith(
                      fontSize: Dimensions.Text16,
                      fontWeight: FontWeight.w600,
                      color: MyColor.titleColor,
                    ),
                  ),
                  const SizedBox(
                    width: Dimensions.space5,
                  ),
                  InkWell(
                    onTap: () async {
                      await Clipboard.setData(
                        ClipboardData(text: commission.id.toString()),
                      );
                    },
                    child: const CustomSvgPicture(
                      image: MyImages.copy,
                      height: 12,
                      width: 12,
                      color: Color(0xFFC8C8C8),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: MyColor.primary,
                  ),
                  color: MyColor.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Level ${commission.level}',
                  style: bodyText.copyWith(
                    fontSize: 10,
                    color: MyColor.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.space15,
          ),
          const Divider(
            color: MyColor.borderColor,
            thickness: 1,
          ),
          const SizedBox(
            height: Dimensions.space12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MyStrings.exchangeCommission.tr,
                    style: bodyText.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.body1,
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.space5,
                  ),
                  Text(
                    '${Converter.formatNumber(commission.amount.toString())} $currency ',
                    style: heading.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: MyColor.title,
                    ),
                  ),
                ],
              ),
              Container(
                color: const Color(0xFFEBE7F0),
                height: 16,
                width: 1.5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    MyStrings.commissionForm.tr,
                    style: bodyText.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.body1,
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.space5,
                  ),
                  Text(
                    commission.userFrom?.username.toString() ?? '',
                    style: heading.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: MyColor.title,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
