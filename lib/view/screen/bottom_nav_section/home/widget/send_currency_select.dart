import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/view/components/dropdawn/send_currency_dropdawon.dart';
import 'package:changa_lab/view/components/text-form-field/custom_amount_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SendCurrencySelect extends StatelessWidget {
  const SendCurrencySelect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: MyColor.borderColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: SendCurrencyDropDawon(
              isBorder: false,
            )),
            SizedBox(
              child: Container(
                color: const Color(0xFFD0D0D0),
                height: 20,
                width: 0.5,
              ),
            ),
            Expanded(
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
