import 'package:changa_lab/core/helper/date_converter.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/model/exchange/exchange_list_model.dart';
import 'package:changa_lab/view/screen/exchange_history/widget/send_receved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExchangeCard extends StatelessWidget {
  final LatestExchange exchange;
  final String imgPath;
  const ExchangeCard({super.key, required this.exchange, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(4),
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
                  exchange.user?.username ?? '',
                  style: heading.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: MyColor.title,
                  ),
                ),
                const SizedBox(
                  height: Dimensions.space5,
                ),
                Text(DateConverter.isoToLocalDateAndTime(exchange.sendCurrency?.createdAt??'0'), style: bodyText),
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
                    text: '${double.parse(exchange.sendingAmount.toString()).toStringAsFixed(2)} ',
                    style: heading.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: MyColor.title,
                    ),
                    children: [
                      TextSpan(
                        text: exchange.sendCurrency?.curSym.toString().toString(),
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
                    text: '${double.parse(exchange.receivingAmount.toString()).toStringAsFixed(2)} ',
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SendReceived(
                      name: MyStrings.send.tr,
                      imgPath: '$imgPath/${exchange.sendCurrency!.image}',
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
                      imgPath: '$imgPath/${exchange.receivedCurrency!.image}',
                      isSvg: false,
                    ),
                  ],
                ),
                Row(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
