import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/exchange/track_exchagne_response_model.dart';
import 'package:changa_lab/view/screen/exchange_prevew/widget/saveing_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackExchangeReceivedDetails extends StatelessWidget {
  final TrackExchange exchange;
  const TrackExchangeReceivedDetails({super.key, required this.exchange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric( vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: MyColor.bg1,
        border: Border.all(color: MyColor.primaryColor.withOpacity(.1)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          SavinglistTile(
            isSendingCharged: false,
            name: MyStrings.receiveMethod.tr,
            value: exchange.receivedCurrency?.name ?? '',
          ),
          SavinglistTile(
            isSendingCharged: false,
            name: MyStrings.receiveCurrency.tr,
            value: exchange.receivedCurrency?.curSym.toString() ?? '',
          ),
          SavinglistTile(
            isSendingCharged: false,
            name: MyStrings.toatalReceiveamount.tr,
            value: Converter.formatNumber(exchange.receivingAmount.toString()),
          ),
          SavinglistTile(
              isSendingCharged: false,
              name: MyStrings.receiveFixedCharge.tr,
              usd: exchange.receivedCurrency?.curSym.toString(),
              value: Converter.formatNumber(
                exchange.charge?.receivingCharge?.fixedCharge.toString() ?? '',
              )),
          SavinglistTile(
              isSendingCharged: true,
              name: MyStrings.receivePersentCharge.tr,
              value: Converter.formatNumber(
                  exchange.charge?.receivingCharge?.percentCharge.toString() ??
                      '')),
          SavinglistTile(
            isSendingCharged: true,
            name: MyStrings.toatalReceiveingCharge.tr,
            isSubTitleBold: true,
            usd: exchange.receivedCurrency?.curSym.toString(),
            value: Converter.formatNumber(
              exchange.charge?.receivingCharge?.totalCharge.toString() ?? '',
            ),
          ),
          SavinglistTile(
            isSendingCharged: false,
            isbottomDevider: false,
            name: MyStrings.toatalReceiveamount.tr,
            usd: exchange.receivedCurrency?.curSym.toString(),
            value: '${Converter.formatNumber(
              exchange.receivingAmount ?? '',
            )} ${exchange.receivedCurrency?.curSym.toString()}',
          ),
        ],
      ),
    );
  }
}
