import 'package:changa_lab/core/helper/date_converter.dart';
import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:changa_lab/data/model/exchange/exchange_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'send_recieve_widget.dart';

// ignore: must_be_immutable
class LatestExchangeCard extends StatelessWidget {
  LatestExchange exchange;

  String imgPath;
  LatestExchangeCard(
      {super.key, required this.exchange, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: Dimensions.space10),
      decoration: BoxDecoration(
        color: MyColor.white,
        borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
        boxShadow: MyUtils.getCardShadow(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${exchange.user?.firstname ?? ''} ${exchange.user?.lastname ?? ''}',
                style: heading.copyWith(fontSize: 12),
              ),
              const SizedBox(
                height: Dimensions.space5,
              ),
              Text(
                  DateConverter.isoToLocalDateAndTime(
                    exchange.createdAt ?? "",
                  ),
                  style: bodyText),
            ],
          ),
          const SizedBox(
            height: Dimensions.space10,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text:
                      '${double.parse(exchange.sendingAmount.toString()).toStringAsFixed(2)} ',
                  style: heading.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: MyColor.title,
                  ),
                  children: [TextSpan(text: exchange.sendCurrency?.curSym)],
                ),
              ),
              SizedBox(
                width: 20,
                child: SvgPicture.asset(
                  MyImages.rightArrow,
                  width: Dimensions.space12,
                  height: Dimensions.space12,
                ),
              ),
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text:
                      '${Converter.formatNumber(exchange.receivingAmount.toString())} ',
                  style: heading.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: MyColor.title,
                  ),
                  children: [
                    TextSpan(
                      text: exchange.receivedCurrency?.curSym.toString(),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.space12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SendReceive(
                name: MyStrings.send.tr,
                imgPath: '$imgPath/${exchange.sendCurrency!.image}',
                isSvg: false,
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                color: const Color(0xFFD0D0D0),
                height: 10,
                width: 1,
              ),
              const SizedBox(
                width: 5,
              ),
              SendReceive(
                name: MyStrings.recevied.tr,
                imgPath: '$imgPath/${exchange.receivedCurrency!.image}',
                isSvg: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
