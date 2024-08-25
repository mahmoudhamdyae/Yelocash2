import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';

import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/core/utils/util.dart';

import 'package:changa_lab/data/controller/home/home_controller.dart';

import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/buttons/rounded_loading_button.dart';

import 'package:changa_lab/view/screen/bottom_nav_section/home/widget/get_currency_select.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/home/widget/send_currency_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeForm extends StatelessWidget {
  const HomeForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(builder: (controller) {
      return Positioned(
        top: 100,
        right: 15,
        left: 15,
        child: Container(
          height: 320,
          width: width,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: MyUtils.getBottomSheetShadow(),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MyStrings.youSend.tr,
                style: appHeading.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: MyColor.body2,
                ),
              ),
              const SizedBox(
                height: Dimensions.space10,
              ),
              const SendCurrencySelect(),
              const SizedBox(height: Dimensions.space5),
              // think from admin end  here  user  end this is buy but from admin end this is sell so that we use minimumLimitForSell instead of minimumLimitForBuy
              controller.selectedSendCurrency != null
                  ? RichText(
                      text: TextSpan(
                        text: '${MyStrings.limit.tr}: ',
                        style: bodyText.copyWith(
                          fontSize: 10,
                          color: MyColor.body2,
                        ),
                        children: [
                          TextSpan(
                              text:
                                  '${Converter.formatNumber(controller.selectedSendCurrency?.minimumLimitForBuy ?? "")} - ${Converter.formatNumber(controller.selectedSendCurrency?.maximumLimitForBuy ?? '')} ${controller.selectedSendCurrency?.curSym}',
                              style: bodyText.copyWith(
                                color: MyColor.primary,
                                fontSize: 10,
                              )),
                        ],
                      ),
                    )
                  : const SizedBox(height: 8),
              const SizedBox(
                height: Dimensions.space20,
              ),
              Text(
                MyStrings.youGet.tr,
                style: appHeading.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: MyColor.body2,
                ),
              ),
              const SizedBox(
                height: Dimensions.space10,
              ),
              const GetCurrencySelect(),
              const SizedBox(height: Dimensions.space5),
              // think from admin end  here  user  end this is buy but from admin end this is sell so that we use minimumLimitForSell instead of minimumLimitForBuy
              controller.selectedbuyCurrency != null
                  ? Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '${MyStrings.limit.tr}: ',
                            style: bodyText.copyWith(
                              fontSize: 10,
                              color: MyColor.body2,
                            ),
                            children: [
                              TextSpan(
                                  text: '${Converter.formatNumber(controller.selectedbuyCurrency?.minimumLimitForSell ?? "")} - ${Converter.formatNumber(controller.selectedbuyCurrency?.maximumLimitForSell ?? '')} ${controller.selectedbuyCurrency?.curSym}',
                                  style: bodyText.copyWith(
                                    color: MyColor.primary,
                                    fontSize: 10,
                                  )),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '${MyStrings.reserve.tr}: ',
                            style: regularDefault.copyWith(
                              fontSize: Dimensions.fontSmall,
                              color: MyColor.body2,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      '${Converter.formatNumber(controller.selectedbuyCurrency?.reserve ?? "")} ${controller.selectedbuyCurrency?.curSym}',
                                  style: regularDefault.copyWith(
                                    color: MyColor.primary,
                                    fontSize: Dimensions.fontSmall,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(height: 8),
              const SizedBox(
                height: Dimensions.space20,
              ),
              Expanded(
                child: GetBuilder<HomeController>(builder: (controller) {
                  return controller.submitLoading
                      ? const RoundedLoadingBtn()
                      : RoundedButton(
                          text: MyStrings.exchangeNow.toUpperCase().tr,
                          press: () {
                            controller.createExchange();
                          },
                          cornerRadius: 8,
                          isOutlined: true,
                        );
                }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
