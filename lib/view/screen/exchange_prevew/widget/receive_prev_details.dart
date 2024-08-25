import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/view/components/column_widget/card_column.dart';
import 'package:changa_lab/view/components/divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/dimensions.dart';

class ReceivePrevDetails extends StatelessWidget {
  const ReceivePrevDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space12,vertical: Dimensions.space15),
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
      child: GetBuilder<HomeController>(builder: (controller) {
        final exchange = controller.prevExchange;
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [

            Row(
              children: [
                Expanded(child: CardColumn(header: 'Received Method', body: exchange.receivedCurrency?.name ?? '')),
                Expanded(child: CardColumn(alignmentEnd:true,header: 'Receive Currency', body:  exchange.receivedCurrency?.curSym.toString() ?? '')),
              ],
            ),
            const CustomDivider(),
            Row(
              children: [
                Expanded(child: CardColumn(header: 'Amount', body: '${Converter.formatNumber(exchange.receivingAmount.toString())} ${exchange.receivedCurrency?.curSym.toString()}')),
                Expanded(child: CardColumn(alignmentEnd:true,header: 'Total Charge', body:  '${Converter.formatNumber(exchange.charge?.receivingCharge?.totalCharge.toString() ?? '')} ${exchange.receivedCurrency?.curSym.toString()}' )),
              ],
            ),
            const CustomDivider(),
            Row(
              children: [
                Expanded(flex:3,child: CardColumn(header: 'Total Receivable Amount', body: '${Converter.sub(exchange.receivingAmount??'0', exchange.charge?.receivingCharge?.totalCharge.toString()??'0')} ${exchange.receivedCurrency?.curSym.toString()}' )),
                Expanded(flex:2,child: CardColumn(alignmentEnd:true,header: 'Exchange ID', body:  exchange.exchangeId.toString() )),
              ],
            ),
          ],
        );
      }),
    );
  }
}
