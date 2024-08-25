
import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/view/components/column_widget/card_column.dart';
import 'package:changa_lab/view/components/divider/custom_divider.dart';
 
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendingPrevDetails extends StatelessWidget {
const  SendingPrevDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space12,vertical: Dimensions.space15),
      decoration: BoxDecoration(
        color: MyColor.bg1,
        boxShadow: MyUtils.getShadow(),
        border: Border.all(color: MyColor.primaryColor.withOpacity(.1)),
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
                Expanded(child: CardColumn(header: 'Send Method', body: exchange.sendCurrency?.name ?? '')),
                Expanded(child: CardColumn(alignmentEnd:true,header: 'Send Currency', body:  exchange.sendCurrency?.curSym.toString() ?? '')),
              ],
            ),
            const CustomDivider(),
            Row(
              children: [
                Expanded(child: CardColumn(header: 'Send Amount', body: '${Converter.formatNumber(exchange.sendingAmount.toString())} ${exchange.sendCurrency?.curSym.toString()}')),
                Expanded(child: CardColumn(alignmentEnd:true,header: 'Total Charge', body:  '${Converter.formatNumber(exchange.charge?.sendingCharge?.totalCharge.toString() ?? '')} ${exchange.sendCurrency?.curSym.toString()}' )),
              ],
            ),
            const CustomDivider(),
            Row(
              children: [
                Expanded(child: CardColumn(header: 'Total Sending Amount', body: '${Converter.sum(
                  exchange.sendingAmount ?? '',
                  exchange.charge?.sendingCharge?.totalCharge.toString() ?? ''
                )} ${exchange.sendCurrency?.curSym.toString()}')),
                Expanded(child: CardColumn(alignmentEnd:true,header: 'Exchange ID', body:  exchange.exchangeId.toString() )),
              ],
            )
          ],
        );
      }),
    );
  }
}
