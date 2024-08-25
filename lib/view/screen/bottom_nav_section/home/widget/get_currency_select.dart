import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/view/components/dropdawn/buy_currency_dropdawn.dart';
import 'package:changa_lab/view/components/text-form-field/custom_amount_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class GetCurrencySelect extends StatelessWidget {
  const GetCurrencySelect({
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
                child: BuyCurrencyDropdawon(
              isBorder: false,
            )),
            SizedBox(
              // width: Dimensions.space5,
              child: Container(
                color: const Color(0xFFD0D0D0),
                height: 20,
                width: 0.5,
              ),
            ),
            Expanded(
                child: CustomAmountTextField(
              labelText: '',
              hintText: controller.getingAmountController.text,
              controller: controller.getingAmountController,
              currency:
                  controller.selectedbuyCurrency?.curSym.toString() ?? '',
              onChanged: (p) {
                if (p.isNotEmpty) {
                  controller.receiveAmountCount(double.parse(p));
                }
              },
              needLabelText: false,
            ))
          ],
        ),
      );
    });
  }
}
