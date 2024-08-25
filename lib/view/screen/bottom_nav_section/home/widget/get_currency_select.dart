import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/view/components/dropdawn/buy_currency_dropdawn.dart';
import 'package:changa_lab/view/components/text-form-field/custom_amount_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/model/currency/buy_currency_modal.dart';

// ignore: must_be_immutable
class GetCurrencySelect extends StatelessWidget {

  final Function(BuyCurrency) onBuy;

  const GetCurrencySelect({
    super.key, required this.onBuy,
  });

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
            BuyCurrencyDropdawon(
              isBorder: true, onBuy: onBuy,
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: MyColor.borderColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: CustomAmountTextField(
                labelText: '',
                hintText: controller.amountSend.toString(),
                controller: controller.getingAmountController,
                currency:
                controller.selectedbuyCurrency?.curSym.toString() ?? 'USD',
                onChanged: (p) {
                  if (p.isNotEmpty) {
                    controller.receiveAmountCount(double.parse(p));
                  }
                },
                needLabelText: false,
              ),
            )
          ],
        ),
      );
    });
  }
}
