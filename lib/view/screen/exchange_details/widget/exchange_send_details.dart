
import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/exchange/exchange_model.dart';
import 'package:changa_lab/view/screen/exchange_prevew/widget/saveing_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeSendingDetails extends StatelessWidget {
  ExchangeModel exchange;
  ExchangeSendingDetails({super.key, required this.exchange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: MyColor.bg1,
        boxShadow: const [
          BoxShadow(
            color: MyColor.unslectedTab,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          SavinglistTile(
            isSendingCharged: false,
            name: MyStrings.sendMethod.tr,
            value: exchange.sendCurrency?.name ?? '',
          ),
          SavinglistTile(
            isSendingCharged: false,
            name: MyStrings.sendCurrency.tr,
            value: exchange.sendCurrency?.curSym.toString() ?? '',
          ),
          SavinglistTile(
              isSendingCharged: false,
              name: MyStrings.sendAmount.tr,
              value: Converter.formatNumber(exchange.sendingAmount.toString())),
          SavinglistTile(
              isSendingCharged: false,
              name: MyStrings.sendingFixedCharge.tr,
              value: Converter.formatNumber(
                exchange.charge?.sendingCharge?.fixedCharge.toString() ?? '',
              )),
          SavinglistTile(
              isSendingCharged: true,
              usd: exchange.sendCurrency?.curSym.toString(),
              name: MyStrings.sendingPersentCharge.tr,
              value: Converter.formatNumber(
                  exchange.charge?.sendingCharge?.percentCharge.toString() ??
                      '')),
          SavinglistTile(
            isSendingCharged: true,
            name: MyStrings.totalSendingCharge.tr,
            usd: exchange.sendCurrency?.curSym.toString(),
            value: Converter.formatNumber(
              exchange.charge?.sendingCharge?.totalCharge.toString() ?? '',
            ),
          ),
          SavinglistTile(
            isSendingCharged: false,
            name: MyStrings.totalSendamount.tr,
            usd: exchange.sendCurrency?.curSym.toString(),
            value: '${Converter.formatNumber(
              exchange.sendingAmount ?? '',
            )} ${exchange.sendCurrency?.curSym.toString()}',
          ),
          SavinglistTile(
            isSendingCharged: false,
            name: MyStrings.yourExcahnageID.tr,
            isTitleBold: true,
            isSubTitleBold: true,
            value: exchange.exchangeId.toString(),
            isbottomDevider: false,
          ),
        ],
      ),
    );
  }
}
