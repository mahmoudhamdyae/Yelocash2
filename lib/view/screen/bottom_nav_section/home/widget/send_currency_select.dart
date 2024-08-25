import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/view/components/dropdawn/send_currency_dropdawon.dart';
import 'package:changa_lab/view/components/text-form-field/custom_amount_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/model/currency/sell_currency_modal.dart';

// ignore: must_be_immutable
class SendCurrencySelect extends StatelessWidget {

  final Function(SellCurrency) onSell;
  const SendCurrencySelect({super.key, required this.onSell});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(builder: (controller) {
      return SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SendCurrencyDropDawon(isBorder: true, onSell:  onSell,),
            const SizedBox(height: 13,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: MyColor.borderColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: CustomAmountTextField(
                labelText: '',
                hintText: controller.receiveAmount.toString(),
                currency:
                controller.selectedSendCurrency?.curSym.toString() ?? 'USD',
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    controller.sendAmountCount(double.tryParse(value) ?? 0);
                  }
                },
                needLabelText: false,
                controller: controller.sendingAmountController,
              ),
            )
          ],
        ),
      );
    });
  }
}
