// ignore_for_file: must_be_immutable

import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:changa_lab/data/model/currency/currency_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodaysRate extends StatelessWidget {
  Currency currency;
  String imgpath;
  TodaysRate({super.key, required this.currency, required this.imgpath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15,vertical: Dimensions.space15),
      decoration: BoxDecoration(
        boxShadow: MyUtils.getShadow(),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: MyColor.borderColor),
        color: MyColor.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 16,
                  backgroundColor: MyColor.transparentColor,
                  backgroundImage: NetworkImage(imgpath),
                ),
                const SizedBox(
                  width: Dimensions.space10,
                ),
                Expanded(child: Text(
                  '${currency.name.toString()} - ${currency.curSym} ',
                  style: bodyText.copyWith(
                    color: MyColor.title,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
          ),
          const SizedBox(width: Dimensions.space10),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        MyStrings.buyAt.tr,
                        style: bodyText.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: Dimensions.space4),
                      // here from api logic has reverse issue. buy will be sell and sell will be buy
                      Text(
                        '${double.parse(currency.sellAt.toString()).toStringAsFixed(2)} ${currency.curSym}',
                        style: bodyText.copyWith(
                          color: MyColor.title,
                          fontSize: Dimensions.fontSmall,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color(0xFFD0D0D0),
                  margin: const EdgeInsets.symmetric(horizontal: Dimensions.space7),
                  height: 30,
                  width: 1,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MyStrings.sellAt.tr,
                        style: bodyText.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: Dimensions.space4),
                      // here from api logic has reverse issue. buy will be sell and sell will be buy
                      Text(
                        '${double.parse(currency.buyAt.toString()).toStringAsFixed(2)} ${currency.curSym}',
                        style: bodyText.copyWith(
                          color: MyColor.title,
                          fontSize: Dimensions.fontSmall,
                          fontWeight: FontWeight.w600
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
