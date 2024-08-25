import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/data/controller/withdraw/add_new_withdraw_controller.dart';
import 'package:changa_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:changa_lab/view/components/text-form-field/custom_amount_text_field.dart';
import 'package:changa_lab/core/utils/util.dart';

import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/divider/custom_divider.dart';
import 'package:changa_lab/view/components/dropdawn/CurrencyDropdawn.dart';
import 'package:changa_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:changa_lab/view/components/text/label_text_with_instructions.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/widraw/widget/withdraw_kyc_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawBody extends StatelessWidget {
  const WithdrawBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return GetBuilder<AddNewWithdrawController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<DashboardController>(builder: (dashController) {
              return Text(
                '${double.parse(dashController.balance).toStringAsFixed(2)} ${homeController.defaultCurrency}',
                style: appHeading.copyWith(
                  color: MyColor.primary,
                  fontSize: Dimensions.Text14,
                  fontWeight: FontWeight.w500,
                ),
              );
            }),
            Text(
              MyStrings.currentBalance.tr,
              style: bodyText,
            ),
            const CustomDivider(
              topSpace: Dimensions.space5,
              bottomSpace: Dimensions.space25,
            ),
            CurrencyDropDawn(
              isBorder: true,
              imgPath: homeController.imagePath,
            ),
            const SizedBox(
              height: Dimensions.space10,
            ),
            Visibility(
              visible: controller.selectedCurrency != null ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${MyStrings.minExchange.tr}: ',
                      style: bodyText.copyWith(
                        fontSize: 10,
                      ),
                      children: [
                        TextSpan(
                            text: '${double.parse(controller.minExchangeAmount.toString() ?? '0.00').toStringAsFixed(2)} ${homeController.defaultCurrency.toString()}',
                            style: bodyText.copyWith(
                              color: MyColor.primary,
                              fontSize: 10,
                            )),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: '${MyStrings.maxExchange.tr}: ',
                        style: bodyText.copyWith(
                          fontSize: 10,
                        ),
                        children: [
                          TextSpan(
                               text: '${double.parse(controller.maxExchangeAmount.toString() ?? '0.00').toStringAsFixed(2)} ${homeController.defaultCurrency.toString()}',
                              style: bodyText.copyWith(
                                color: MyColor.primary,
                                fontSize: 10,
                              )),
                        ]),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: Dimensions.space25,
            ),
            Container(
              decoration: BoxDecoration(
                color: MyColor.white,
                boxShadow: MyUtils.getBottomSheetShadow(),
                border: Border.all(
                  color: MyColor.getTextFieldDisableBorder(),
                  width: .5,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: CustomAmountTextField(
                labelText: '',
                hintText: '',
                currency: homeController.defaultCurrency.toString() ?? '',
                onChanged: (p) {
                  if (p.isEmpty || !controller.isNumeric(p) || double.tryParse(p) == 0) {
                    controller.updateConversionAmountController(0);
                  } else {
                    controller.countConversion();
                  }
                },
                needLabelText: false,
                controller: controller.sendingAmountController,
              ),
            ),
            const SizedBox(
              height: Dimensions.space25,
            ),
            const LabelTextInstruction(text: MyStrings.getAmount),
            Container(
              decoration: BoxDecoration(
                color: MyColor.white,
                boxShadow: MyUtils.getBottomSheetShadow(),
                border: Border.all(
                  color: MyColor.getTextFieldDisableBorder(),
                  width: .5,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  CustomAmountTextField(
                    readOnly: true,
                    labelText: '',
                    hintText: '',
                    currency: controller.selectedCurrency?.curSym.toString() ?? '',
                    onChanged: (p) {
                      if (p.isNotEmpty && controller.isNumeric(p)) {}
                    },
                    needLabelText: false,
                    controller: controller.conversionAmountController,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: Dimensions.space25,
            ),
            CustomTextField(
              onChanged: (value) {},
              animatedLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.walletNidNum.tr,
              hintText: MyStrings.walletNidNum.tr,
              controller: controller.walletController,
            ),
            const SizedBox(
              height: Dimensions.space25,
            ),
            GetBuilder<AddNewWithdrawController>(builder: (widthControlle) {
              return const Visibility(
                visible: true,
                child:  WithdrawKYCSection(),
              );
            }),
            const SizedBox(
              height: Dimensions.space25,
            ),
            controller.submitLoading
                ? const RoundedLoadingBtn()
                : RoundedButton(
                    text: MyStrings.withdrawNow.tr.toUpperCase(),
                    press: () {
                      if (controller.formList.isNotEmpty) {
                        if (controller.formKey.currentState!.validate()) {
                          controller.withdrawNow();
                        }
                      } else {
                        controller.withdrawNow();
                      }
                    },
                    isOutlined: true,
                  )
          ],
        );
      });
    });
  }
}
