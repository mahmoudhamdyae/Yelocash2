// ignore_for_file: unrelated_type_equality_checks


import 'package:changa_lab/core/helper/date_converter.dart';
import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/model/exchange/exchange_history_model.dart';
import 'package:changa_lab/view/screen/exchange_history/widget/send_receved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExchangeHistoryCard extends StatelessWidget {
  String imagePath;
  HistoryExchange historyExchange;
  ExchangeHistoryCard(
      {super.key, required this.historyExchange, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          RouteHelper.exchangeDetails,
          arguments: [historyExchange.id],
        );
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: MyColor.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${historyExchange.exchangeId}',
                      style: heading.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: MyColor.title,
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.space5,
                    ),
                    Text(
                        DateConverter.isoToLocalDateAndTime(
                          historyExchange.createdAt ?? "",
                        ),
                        style: bodyText),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.space12,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text:
                            '${double.parse(historyExchange.sendingAmount.toString()).toStringAsFixed(2)} ',
                        style: heading.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: MyColor.title,
                        ),
                        children: [
                          TextSpan(
                            text: historyExchange.sendCurrency.curSym
                                .toString()
                                .toString(),
                          )
                        ],
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
                            '${double.parse(historyExchange.receivingAmount.toString()).toStringAsFixed(2)} ',
                        style: heading.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: MyColor.title,
                        ),
                        children: [
                          TextSpan(
                            text: historyExchange.receivedCurrency.curSym
                                .toString(),
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
                    SendReceived(
                      name: MyStrings.send.tr,
                      imgPath:
                          '$imagePath/${historyExchange.sendCurrency.image}',
                      isSvg: false,
                    ),
                    const SizedBox(
                      width: Dimensions.space10,
                    ),
                    Container(
                      color: const Color(0xFFD0D0D0),
                      height: 15,
                      width: 1.5,
                    ),
                    const SizedBox(
                      width: Dimensions.space10,
                    ),
                    SendReceived(
                      name: MyStrings.recevied.tr,
                      imgPath:
                          '$imagePath/${historyExchange.receivedCurrency.image}',
                      isSvg: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: historyExchange.status == "2"
                      ? MyColor.pendingColor
                      : historyExchange.status == "1"
                          ? MyColor.greenSuccessColor
                          : MyColor.redCancelTextColor,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                historyExchange.status == "2"
                    ? 'Pending'
                    : historyExchange.status == "1"
                        ? 'Success'
                        : 'Canceled',
                style: bodyText.copyWith(
                  fontSize: 10,
                  color: historyExchange.status == "2"
                      ? MyColor.pendingColor
                      : historyExchange.status == "1"
                          ? MyColor.greenSuccessColor
                          : MyColor.redCancelTextColor,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: [
                Text(
                  MyStrings.viewMore.tr,
                  style: bodyText.copyWith(fontSize: 10),
                ),
                const SizedBox(
                  width: 5,
                ),
                SvgPicture.asset(
                  MyImages.angelSmallrightArrow,
                  height: 16,
                  width: 16,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
